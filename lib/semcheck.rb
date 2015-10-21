require_relative "semcheck/version"
require 'mechanize'
require 'rest-client'
require 'crack' # for xml and json

module Semcheck
  class Application
    THESAURUS_API_KEY =  "jbvSLnAGjO55Im0KsKU4"
    THESAURUS_API_HOST = "http://thesaurus.altervista.org/thesaurus/v1"
    attr_accessor :terms, :synonyms, :schemas

    def initialize(args)
      @terms = args
    end

    def run
      puts "Searching semweb resources for: #{terms}"
      @synonyms = []
      terms.split(",").each do |term|
        RestClient.get(
          THESAURUS_API_HOST,
          {
            :params => {
              'word' => term,
              'language' => 'en_US',
              'key' => THESAURUS_API_KEY
            },
            :content_type => :json
          }
        ) do |response, request, result, &block|
          case result.code
          when 404
            []
          else
            maybe_list = Crack::XML.parse(
              response
            )["response"]["list"]
            @synonyms << (
              maybe_list.size == 2 ? maybe_list["synonyms"] : maybe_list.first["synonyms"]
            ).to_s.split("|")
          end
        end
      end

      schema_org_search_form = agent.get("https://schema.org/").form("gsc-search-box")
      results = agent.submit(schema_org_search_form, schema_org_search_form.buttons.first)
puts results
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
