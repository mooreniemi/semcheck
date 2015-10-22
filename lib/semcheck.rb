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

      # schema.org just uses google to do search
      schemas << Google::Search::Web.new do |search|
        search.query = "site:schema.org " + maybe_array_of(terms).join(" OR ")
      end.map(&:uri)

      schemas << Google::Search::Web.new do |search|
        search.query = "site:schema.org " + maybe_array_of(synonyms).join(" OR ")
      end.map(&:uri)

      @schemas = schemas.flatten.reject! do |url|
        blacklist.include?(url)
      end.uniq

      return self
    end

    private
    def maybe_array_of(words)
      if words.is_a? Array
        words
      else
        [words]
      end
    end
    def agent
      @agent = Mechanize.new
    end
    def blacklist
      [
        "http://schema.org/docs/schema_org_rdfa.html",
        "https://schema.org/docs/schemaorg.owl",
        "http://schema.org/version/2.0/",
        "http://schema.org/version/2.1/",
        "http://blog.schema.org/2011/11/schemaorg-support-for-job-postings.html",
        "https://bib.schema.org/"
      ]
    end
  end
end
