require_relative "string_refinements"

class WordSearchHelper
  using StringRefinements

  def initialize(trie)
    @trie = trie
  end

  # TODO: The separation of responsibilties is weird here between this method
  # and the one below. This needs to be refactored.
  def partition_with_subtree(word)
    word.tokenize_by_pivot.lazy.map do |prefix, *args|
      # TODO: Should we be returning an object here rather than a tuple?
      [prefix] + args + [@trie.get(prefix)]
    end
  end

  def neighbors_by_substitution(word)
    # TODO: Why do we need to flat map here?
    partition_with_subtree(word).flat_map do |prefix, char_to_substitute, suffix, subtree|
      # Steps:
      #
      #   1. There's no point in substituting the letter that was already there
      #      since that just gives us back the word we had originally.
      #
      #   2. The word has to exist in the subtree or else it's not a word which
      #      is contained in the dictionary.
      #
      subtree.lazy
        .reject do |substitution_possibility, _|
          substitution_possibility == char_to_substitute
        end
        .select do |_, substitution_possibility_subtree|
          substitution_possibility_subtree.contains?(suffix)
        end
        .map { |substitution_possibility, _| prefix + substitution_possibility + suffix }
    end
  end
end
