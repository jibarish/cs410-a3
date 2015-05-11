require 'enumerator'
require_relative 'character'

def parse_file
  # Read in data
  data = File.open("UnicodeDataClean.txt", "r"){ |f| f.read.split("\n") }
  
  output = File.open("unicode_data.rb", 'w')

  character_format = "Character.new(\"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\")"
  hash_format = "    hash[\"%s\"] = %s"
  trie_open = "    trie[\"%s\"] = \"%s\""

  output.puts "require 'singleton'"
  output.puts "require_relative 'trie'"
  output.puts "require_relative 'character'"

  output.puts "class UnicodeData"
  output.puts "  include Singleton"
  output.puts "  attr_reader :hash, :trie"
  output.puts "  def initialize"
  output.puts "    @hash = Hash.new"
  output.puts "    @trie = Trie.new"

  # Store unicode character objects in an array
  @charlist = []
  for each in data
    t = each.strip.split(";", -1)
    if t.length != 7
      raise "Data file is not formatted as expected or was read incorrectly."
    end
    charinit = character_format % [t[0], t[1], t[2], t[3], t[4], t[5], t[6]]
    output.puts hash_format % [t[0], charinit]
    output.puts trie_open % [t[1], t[0]]
  end
  output.puts "  end"
  output.puts "end"
  output.close unless output == nil
end


parse_file
