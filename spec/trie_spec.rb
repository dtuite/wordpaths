require_relative "spec_helper"
require_relative "../lib/trie"

describe Trie do
  describe "#initialize" do
    it "doesn't allow passing regular Hash arguments" do
      expect { described_class.new(0) }.to raise_error(ArgumentError)
    end

    it "supports specified branch endings" do
      subject = described_class.new(branch_end_key: 'a')
      subject.put('hl')
      expect(subject.get('h')).to eq('l' => { 'a' => nil })
    end
  end

  describe "#put" do
    it "puts items in the tree branches" do
      subject.put('he')
      expect(subject['h']).to eq('e' => { nil => nil })
    end
  end

  describe "#get" do
    it "plucks from branches of the tree" do
      subject.put('hel')
      expect(subject.get('he')).to eq('l' => { nil => nil })
    end
  end

  describe "#contains?" do
    before { subject.put('hello') }

    it "returns true if a word occupies a full branch" do
      expect(subject.contains?('hello')).to eq(true)
    end

    it "returns true if a sub-word is put in the tree" do
      subject.put('hell')
      expect(subject.contains?('hell')).to eq(true)
    end

    it "returns false if a word doesn't fill a branch" do
      expect(subject.contains?('hel')).to eq(false)
    end

    it "returns false if a word is longer than a branch" do
      expect(subject.contains?('hellooo')).to eq(false)
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

  describe "#neighbors_by_substitution" do
    it "finds neighboring words by substituting letters" do
      dict_path = File.expand_path(File.join(*%w[spec fixtures first_3000_words]))
      trie = Trie.from_dict(dict_path)
      subject = trie.neighbors_by_substitution("able")
      expect(subject.next).to eq('acle')
    end
  end
end
