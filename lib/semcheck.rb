require_relative "semcheck/version"
require 'mechanize'
require 'rest-client'
require 'crack' # for xml and json

module Semcheck
  class Application
    THESAURUS_API_KEY =  "jbvSLnAGjO55Im0KsKU4"
    THESAURUS_API_HOST = "http://thesaurus.altervista.org/thesaurus/v1"
    attr_accessor :terms

    def initialize(args)
      @terms = args
    end

    def run
      puts "Searching semweb resources for: #{terms}"
      synonyms = RestClient.get(
        THESAURUS_API_HOST,
        {
          :params => {
            'word' => terms,
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
          (
            maybe_list.size == 2 ? maybe_list["synonyms"] : maybe_list.first["synonyms"]
          ).to_s.split("|")
        end
      end

      return synonyms
    end
  end
end
