require_relative "../lib/searcher"
require "benchmark"

searcher = Searcher.new

[
  { start: 'dog', goal: 'cat', len: 4},
  { start: 'dung', goal: 'geet', len: 5},
  { start: 'flute', goal: 'david', len: 13},
].each do |test|
  benchmark = Benchmark.benchmark(Benchmark::CAPTION, 50, Benchmark::FORMAT) do |reporter|
    reporter.report("'#{test[:start]}' --> '#{test[:goal]}' (path length: #{test[:len]})".ljust(40)) {
      searcher.search(start: test[:start], goal: test[:goal])
    }
  end
end
