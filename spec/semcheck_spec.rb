require 'spec_helper'

describe Semcheck do
  it 'has a version number' do
    expect(Semcheck::VERSION).not_to be nil
  end

  describe "Application" do
    it 'can be initialized with command line args' do
      expect(Semcheck::Application.new("foo")).to be_a(Semcheck::Application)
      expect(Semcheck::Application.new("foo").terms).to eq("foo")
    end
    describe "#run" do
      it 'returns terms' do
        expect{ Semcheck::Application.new("foo").run }.to output("you gave me foo\n").to_stdout
      end
    end
  end
end
