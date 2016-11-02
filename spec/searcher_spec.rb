require_relative "spec_helper"
require_relative "../lib/searcher"

describe Searcher do
  before(:all) do
    # Cache the subject because reloading the dictionary takes a long time.
    @searcher = described_class.new
  end

  [
    %w[rial real feal foal foul foud],
    %w[cat cot dot dog],
    %w[he ha]
  ].each do |expected|
    it "finds a path from '#{expected[0]}' --> '#{expected[-1]}'" do
      path = @searcher.search(start: expected[0], goal: expected[-1])
      expect(path).to eq(expected.map(&:to_s))
    end
  end

  it "works with a single length path" do
    expect(@searcher.search(start: 'cat', goal: 'cat')).to eq(%w[cat])
  end

  [
    { start: nil, goal: nil },
    { start: false, goal: "cat" },
    { start: "dog", goal: "cats" },
    { start: :dog, goal: "cats" }
  ].each do |inputs|
    it "deals with illegal '#{inputs[:start]}' --> '#{inputs[:goal]}'" do
      path = @searcher.search(inputs)
      expect(path).to eq(nil)
    end
  end

  it "handles kjd" do
    path = @searcher.search(goal: 'banana', start: 'end')
    expect(path).to eq(nil)
  end

  describe "#inspect" do
    # This is kinda controversial but if you don't override inspect then
    # instanciating a Searcher at the command line with result in printing the
    # entire trie to the screen.
    it "returns nil" do
      expect(@searcher.inspect).to be_nil
    end
  end
end
