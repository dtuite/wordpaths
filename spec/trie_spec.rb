require_relative "spec_helper"
require_relative "../trie"

describe Trie do
  describe "#initialize" do
    it "doesn't allow passing arguments" do
      expect { described_class.new(0) }.to raise_error(ArgumentError)
    end
  end

  describe "#put" do
    it "puts items in the tree branches" do
      subject.put('he')
      expect(subject['h']).to eq('e' => described_class.new)
    end
  end

  describe "#get" do
    it "plucks from branches of the tree" do
      subject.put('hel')
      expect(subject.get('he')).to eq({ 'l' => {} })
    end

    it "deals with nil words" do
      expect(subject.get(nil)).to eq(nil)
    end
  end

  describe "::from_dict" do
    let(:dict_path) { File.expand_path(File.join(*%w[spec fixtures words])) }
    subject { described_class.from_dict(dict_path) }

    it "builds a trie from a dictionary file" do
      expect(subject['a']['b']['a']['c']['y']).to be_nil
    end

    it "downcases words" do
      expect(subject['A']).to be_nil
    end

    it "chomps lines" do
      expect(subject['a']['b']["\n"]).to be_nil
    end
  end
end
