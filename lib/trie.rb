require_relative "string_refinements"

class Trie < Hash
  using StringRefinements

  DEFAULT_DICTIONARY_PATH = File.expand_path(File.join(*%w[/ usr share dict web2]))

  def initialize(branch_end_key: nil, branch_end_value: nil)
    super()
    @branch_end_key = branch_end_key
    @branch_end_value = branch_end_value
  end

  def put(word)
    final_trie = word.each_char.inject(self) do |trie, char|
      trie[char] ||= self.class.new
    end
    final_trie[@branch_end_key] = @branch_end_value
    self
  end

  def get(word)
    return unless word
    word.each_char.inject(self) { |trie, char| trie && trie.fetch(char, nil) }
  end

  def contains?(word)
    subtrie = get(word)
    !!subtrie && subtrie.has_key?(@branch_end_key)
  end

  def self.from_dict(path = DEFAULT_DICTIONARY_PATH)
    File.open(path) do |file|
      file.each_line.each_with_object(new) do |line, memo|
        memo.put(line.chomp.downcase)
      end
    end
  end

  # We use #flat_map to ensure that the return value is decomposed. Check
  # the Ruby Enumerator::Lazy docs for more information.
  #
  # Steps:
  #
  #   1. Split the word up and reorganize the trie into prefixes and subtries
  #      for easier enumeration.
  #
  #   2. There's no point in substituting the letter that was already there
  #      since that just gives us back the word we had originally.
  #
  #   3. The word has to exist in the subtree or else it's not a word which
  #      is contained in the dictionary.
  #
  #   4. We need to rejoin the word before we return it.
  #
  def neighbors_by_substitution(word)
    word.split_around_each_char.lazy
      .flat_map do |prefix, char_to_substitute, suffix|
        get(prefix).lazy
          .reject do |substitution_possibility, _|
            substitution_possibility == char_to_substitute
          end
          .select do |_, substitution_possibility_subtree|
            # I'd usually use #try here but the instructions specify that I
            # can't include ant ActiveSupport functions.
            substitution_possibility_subtree &&
              substitution_possibility_subtree.contains?(suffix)
          end
          .map do |substitution_possibility, _|
            prefix + substitution_possibility + suffix
          end
      end
  end
end
