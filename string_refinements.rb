module StringRefinements
  refine String do
    def tokenize_by_char
      0.upto(self.length).map { |i| [self[0...i], self[i..-1]] }
    end

    # TODO: I prefer the word #partition for this.
    def tokenize_by_pivot
      self.chars.each_with_index.map do |char, i|
        [self[0...i], char, self[(i+1)..-1]]
      end
    end
  end
end
