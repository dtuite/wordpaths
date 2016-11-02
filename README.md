## Installation

    bundle
    cp .rspec.dist .rspec

## Usage

    ./script/words cat dog [OPTIONS]

You can optionally pass a dictionary file with the `--dict=PATH` option.

## Running Specs

    be rspec spec

## Running Benchmarks

    be ruby spec/benchmarks.rb

### Notes

Tested with Ruby 2.2.2 (see the `.ruby-version` file).

There's three main files:

  - `lib/trie.rb` - An implementation of a Trie created by subclassing `Hash`.
  - `lib/searcher.rb` - A Breath First Search implementation.
  - `lib/string_refinements.rb` - Helper methods used in the `Trie`.

