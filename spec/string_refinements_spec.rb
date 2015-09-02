require "spec_helper"
require_relative "../string_refinements"

describe StringRefinements do
  using StringRefinements

  describe "#tokenize_by_char" do
    it "splits a word into adjacent tokens" do
      expect('abc'.tokenize_by_char).to eq([
        ['', 'abc'],
        ['a', 'bc'],
        ['ab', 'c'],
        ['abc', '']
      ])
    end
  end
end
