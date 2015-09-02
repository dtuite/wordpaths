require_relative "trie"
require "set"

class Searcher
  def initialize
    @trie = Trie.from_dict
  end

  def search(start_vertex, goal_vertex)
    visited_vetices = Set.new
    queue.push([start_vertex])

    until queue.empty?
      path = queue.pop
      current_vertex = path.last

      return path if current_vertex = goal_vertex
      unless visited_vetices.include?(current_vertex)
        visited_vetices.add(current_vertex)

        @trie.adjacent_to(current_vertex).each do |neighbor|
          unless visited_vetices.include?(neighbor)
            queue.push(path + [neighbor])
          end
        end
      end
    end
  end
end
