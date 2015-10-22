require_relative "semcheck/version"
require 'bronto'
require 'dinosaurus'
require 'rdf'
require 'linkeddata'
# require 'mechanize'
# require 'rest-client'
# require 'crack' # for xml and json

module Semcheck
  class Application
    attr_accessor :terms, :synonyms, :schemas, :schema_graph

    def initialize(args)
      @terms = args
      @synonyms = []
      @schema_graph = RDF::Graph.load("http://schema.org/docs/schema_org_rdfa.html")
      @schemas = []
    end

    def run
      puts "Searching semweb resources for: #{terms}"
      terms.split(",").each do |term|
        results = Bronto::Thesaurus.new.lookup(term)
        if !results.nil?
          results.keys.each do |word_type|
            synonyms << results[word_type][:syn]
          end
        end
      end
      synonyms.flatten!

      synonyms.each do |term|
        schemas << RDF::Query.new(
          {
            thing: { RDF::URI("http://www.w3.org/2000/01/rdf-schema#label") => term}
          }
        ).execute(schema_graph)
      end
      return self
    end

    private
    def all_candidates
      terms + synonyms
    end
    def agent
      @agent = Mechanize.new
    end
  end
end
