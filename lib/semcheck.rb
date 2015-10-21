require_relative "semcheck/version"

module Semcheck
  class Application
    attr_accessor :terms

    def initialize(args)
      @terms = args
    end

    def run
      puts "you gave me #{terms}"
    end
  end
end
