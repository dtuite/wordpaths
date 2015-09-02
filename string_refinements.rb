module StringRefinements
  refine String do
    def tokenize_by_char
      0.upto(self.length).map { |i| [self[0...i], self[i..-1]] }
    end
  end
end
