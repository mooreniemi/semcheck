require_relative "semcheck/version"
require 'bronto'
require 'mechanize'
require 'rest-client'
require 'crack' # for xml and json

module Semcheck
  class Application
    attr_accessor :terms, :synonyms, :schemas

    def initialize(args)
      @terms = args
      @synonyms = []
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

      #schema_org_search_form = agent.get("https://schema.org/").form("gsc-search-box")
      #results = agent.submit(schema_org_search_form, schema_org_search_form.buttons.first)
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
