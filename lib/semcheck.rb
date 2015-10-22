require_relative "semcheck/version"
require 'bronto'
require 'dinosaurus'
require 'google-search'
# require 'mechanize'
# require 'rest-client'
# require 'crack' # for xml and json

module Semcheck
  class Application
    attr_accessor :terms, :synonyms, :schemas

    def initialize(args)
      @terms = args
      @synonyms = []
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
        # schema.org just uses google to do search
        schemas << Google::Search::Web.new do |search|
          search.query = "house" + " site:schema.org"
        end.map(&:uri)
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
