module StringRefinements
  refine String do
    def split_before_each_char
      0.upto(self.length).map { |i| [self[0...i], self[i..-1]] }
    end

    def split_around_each_char
      self.chars.each_with_index.map do |char, i|
        [self[0...i], char, self[(i+1)..-1]]
      end
    end
  end
end
