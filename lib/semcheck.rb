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

      string_or_array_of(terms).each do |term|
        # bronto gives us a sparse, but local dict
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

      # oddly, if i just do a giant or chain i can lose
      # the results i wouldve gotten from the single term
      schemas << Google::Search::Web.new do |search|
        search.query = "site:schema.org " + maybe_array_of(synonyms).join(" OR ")
      end.map(&:uri)

      @schemas = schemas.flatten.reject! do |url|
        blacklist.include?(url) || url =~ schema_blog
      end.uniq

      puts "Possible schema matches: #{schemas.join("\n")}"

      return self
    end

    private
    def string_or_array_of(terms)
      if terms.is_a? Array
        terms
      else
        terms.split(",")
      end
    end
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
        "https://schema.org/docs/full.html",
        "https://schema.org/QAPage",
        "https://schema.org/docs/datamodel.html",
        "https://schema.org/docs/schemas.html",
        "https://schema.org/docs/actions.html",
        "http://schema.org/version/2.0/schema.rdfa",
        "https://schema.org/docs/gs.html",
        "https://schema.org/",
        "https://bib.schema.org/"
      ]
    end
    def schema_blog
      /http:\/\/blog.schema.org\//
    end
  end
end
