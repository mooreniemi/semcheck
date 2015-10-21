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
      let(:restaurant_synonyms) do
        ["eating house","eating place", "building", "edifice"]
      end
      let(:house_synonyms) do
        ["dwelling", "home", "domicile", "abode", "habitation", "dwelling house", "building", "edifice"]
      end

      it 'returns terms to stdout' do
        expect { Semcheck::Application.new("house").run }.
          to output("Searching semweb resources for: house\n").to_stdout
      end
      it 'gets synonyms for a term' do
        # compare to how much better the results are from
        # http://www.thesaurus.com/browse/restaurant?s=t
        expect(Semcheck::Application.new("restaurant").run.synonyms).
          to eq([restaurant_synonyms])
      end
      it 'gets synonyms for terms' do
        expect(Semcheck::Application.new("restaurant,house").run.synonyms).
          to eq([restaurant_synonyms, house_synonyms])
      end
      it 'gets potential schema matches for terms and synonyms' do
        expect(Semcheck::Application.new("house").run.schemas).
          to eq(["HousePainter", "Residence", "RentAction", "JobPosting", "Organization"])
      end
    end
  end
end
