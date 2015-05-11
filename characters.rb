require 'enumerator'
require 'singleton'
require_relative 'character'

class Characters
  include Singleton
  include Enumerable
  attr_reader :charlist, :hash, :trie

  def initialize
    # Read in data
    data = File.open("UnicodeDataClean.txt", "r"){ |f| f.read.split("\n") }

    # Store unicode character objects in an array
    @hash = Hash.new
    @trie = Trie.new
    @charlist = []
    for each in data
      t = each.strip.split(";", -1)
      if t.length != 7
        raise "Data file is not formatted as expected or was read incorrectly."
      end
      @charlist << Character.new(t[0], t[1], t[2], t[3], t[4], t[5], t[6])
      @hash[t[0]] = Character.new(t[0], t[1], t[2], t[3], t[4], t[5], t[6])
      @trie[t[1]] = t[0]
    end
  end

  def each
    @charlist.each { |i| yield i }
  end
end
