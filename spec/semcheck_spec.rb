require 'spec_helper'

describe Semcheck do
  it 'has a version number' do
    expect(Semcheck::VERSION).not_to be nil
  end

  describe "Application" do
    it 'can be initialized with command line args' do
      expect(Semcheck::Application.new("house")).to be_a(Semcheck::Application)
      expect(Semcheck::Application.new("house").terms).to eq("house")
    end
    describe "#run" do
      it 'returns terms to stdout' do
        expect { Semcheck::Application.new("house").run }.
          to output("Searching semweb resources for: house\n").to_stdout
      end
      it 'gets synonyms for terms' do
        expect(Semcheck::Application.new("restaurant").run).
          to eq(["eating house","eating place", "building", "edifice"])
      end
    end
  end
end
