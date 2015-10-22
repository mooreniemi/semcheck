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
      let(:friend_synonyms) do
        ["acquaintance", "admirer", "advocate", "advocator", "ally", "associate", "booster", "champion", "christian", "exponent", "individual", "mortal", "person", "proponent", "protagonist", "quaker", "somebody", "someone", "soul", "supporter"]
      end
      let(:house_synonyms) do
        ["abode", "audience", "building", "business", "business concern", "business firm", "business organisation", "business organization", "child's play", "community", "concern", "domicile", "dwelling", "dwelling house", "edifice", "family", "family line", "firm", "folk", "general assembly", "habitation", "home", "household", "kinfolk", "kinsfolk", "law-makers", "legislative assembly", "legislative body", "legislature", "management", "mansion", "menage", "part", "phratry", "planetary house", "play", "region", "sept", "sign", "sign of the zodiac", "social unit", "star sign", "theater", "theatre", "unit", "accommodate", "admit", "domiciliate", "hold", "put up", "shelter"]
      end

      it 'returns terms to stdout' do
        expect { Semcheck::Application.new("house").run }.
          to output("Searching semweb resources for: house\n").to_stdout
      end
      it 'gets synonyms for a term' do
        expect(Semcheck::Application.new("house").run.synonyms).
          to eq(house_synonyms)
      end
      it 'gets synonyms for terms' do
        expect(Semcheck::Application.new("friend,house").run.synonyms).
          to eq(friend_synonyms + house_synonyms)
      end
      it 'gets potential schema matches for terms and synonyms' do
        expect(Semcheck::Application.new("house").run.schemas).
          to eq(["HousePainter", "Residence", "RentAction", "JobPosting", "Organization"])
      end
    end
  end
end
