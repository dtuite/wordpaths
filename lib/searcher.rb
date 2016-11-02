require_relative "trie"
require "set"
require "awesome_print"

class Searcher
  def initialize(trie = Trie.from_dict)
    @trie = trie
  end

  def search(start:, goal:)
    return unless goal.is_a?(String) && start.is_a?(String)
    # We're only using substitution so it's impossible to gets paths between
    # words of different lengths. Might as well catch it early.
    return if start.length != goal.length

    visited_vetices = Set.new
    queue = []
    queue.push([start])

    until queue.empty?
      path = queue.shift
      current_vertex = path.last

      return path if current_vertex == goal

      unless visited_vetices.include?(current_vertex)
        visited_vetices.add(current_vertex)

        @trie.neighbors_by_substitution(current_vertex).each do |neighbor|
          unless visited_vetices.include?(neighbor)
            queue.push(path + [neighbor])
          end
        end
      end
    end
  end

  def inspect
    nil
  end
end
