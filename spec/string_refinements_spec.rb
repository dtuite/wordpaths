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

  describe "tokenize_by_pivot" do
    it "splits a word with one char in the middle" do
      expect('abc'.tokenize_by_pivot).to eq([
        ['', 'a', 'bc'],
        ['a', 'b', 'c'],
        ['ab', 'c', '']
      ])
    end

    it "splits words which have repeated letters" do
      expect('abcbc'.tokenize_by_pivot).to eq([
        ['', 'a', 'bcbc'],
        ['a', 'b', 'cbc'],
        ['ab', 'c', 'bc'],
        ['abc', 'b', 'c'],
        ['abcb', 'c', '']
      ])
    end
  end
end
