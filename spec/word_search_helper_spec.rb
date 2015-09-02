require_relative "spec_helper"
require_relative "../word_search_helper"
require_relative "../trie"

describe WordSearchHelper do
  describe "#partition_with_subtree" do
    it "lazily enumerates a word's partitions and their sub-trees" do
      dict_path = File.expand_path(File.join(*%w[spec fixtures words]))
      trie = Trie.from_dict(dict_path)
      helper = WordSearchHelper.new(trie)
      subject = helper.partition_with_subtree("abac")
      expect(subject.next).to eq(['', 'abac', trie.get('')])
      expect(subject.next).to eq(['a', 'bac', trie.get('a')])
      expect(subject.next).to eq(['ab', 'ac', trie.get('ab')])
      expect(subject.next).to eq(['aba', 'c', trie.get('aba')])
      expect(subject.next).to eq(['abac', '', trie.get('abac')])
      expect { subject.next }.to raise_error(StopIteration)
    end
  end
end
