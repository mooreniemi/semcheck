require 'spec_helper'

describe Semcheck do
  it 'has a version number' do
    expect(Semcheck::VERSION).not_to be nil
  end

  describe "Application" do
    it 'can be initialized with command line args' do
      expect(Semcheck::Application.new("house")).to be_a(Semcheck::Application)
      expect(Semcheck::Application.new("house").terms).to include("house")
    end
    it 'can ingest an interpret option flags' do
      expect(Semcheck::Application.new(["-M", "house"]).flags).to eq(["-M"])
    end
    describe "#run" do
      it 'returns terms to stdout' do
        expect { Semcheck::Application.new("house").run }.
          to output(Words::OUTPUT_STRING).to_stdout
      end
      it 'gets synonyms for a term' do
        expect(Semcheck::Application.new("house").run.synonyms).
          to eq(Words::HOUSE_SYNONYMS)
      end
      it 'gets synonyms for terms' do
        expect(Semcheck::Application.new("friend,house").run.synonyms).
          to eq(Words::FRIEND_SYNONYMS + Words::HOUSE_SYNONYMS)
      end
      it 'gets potential schema matches for terms and synonyms' do
        expect(Semcheck::Application.new("house").run.schemas).
          to eq(Words::SCHEMAS)
      end
    end
  end
end
