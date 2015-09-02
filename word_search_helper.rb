require_relative "string_refinements"

class WordSearchHelper
  using StringRefinements

  def initialize(trie)
    @trie = trie
  end

  def partition_with_subtree(word)
    word.tokenize_by_char.lazy.map do |(prefix, suffix)|
      [prefix, suffix, @trie.get(prefix)]
    end
  end
end
