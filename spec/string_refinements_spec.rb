require "spec_helper"
require_relative "../lib/string_refinements"

describe StringRefinements do
  using described_class

  describe "#split_before_each_char" do
    it "splits a word into adjacent tokens" do
      expect('abc'.split_before_each_char).to eq([
        ['', 'abc'],
        ['a', 'bc'],
        ['ab', 'c'],
        ['abc', '']
      ])
    end
  end

  describe "#split_around_each_char" do
    it "splits a word with one char in the middle" do
      expect('abc'.split_around_each_char).to eq([
        ['', 'a', 'bc'],
        ['a', 'b', 'c'],
        ['ab', 'c', '']
      ])
    end

    it "splits words which have repeated letters" do
      expect('abcbc'.split_around_each_char).to eq([
        ['', 'a', 'bcbc'],
        ['a', 'b', 'cbc'],
        ['ab', 'c', 'bc'],
        ['abc', 'b', 'c'],
        ['abcb', 'c', '']
      ])
    end
  end
end
