class Trie < Hash
  DEFAULT_DICTIONARY_PATH = File.expand_path(File.join(*%w[usr share dict web2]))

  def initialize
    super
  end

  def put(word)
    word.each_char.inject(self) do |memo, char|
      memo[char] ||= self.class.new
    end
  end

  def self.from_dict(path = DEFAULT_DICTIONARY_PATH)
    File.open(path) do |file|
      file.each_line.each_with_object(new) do |line, memo|
        memo.put(line.chomp.downcase)
      end
    end
  end
end
