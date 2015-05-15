require 'enumerator'
require_relative 'character'

def parse_file
  # Read in data
  data = File.open("unicode_data_clean.txt", "r"){ |f| f.read.split("\n") }

  output = File.open("unicode_data.rb", 'w')

  character_format = "Character.new(\"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\")"
  cp_hash_format = "    cp_hash[\"%s\"] = %s"
  trie_open = "    trie[\"%s\"] = %s"
  alias_hash_format = "    alias_hash[\"%s\"] = %s"

  output.puts "require 'singleton'"
  output.puts "require_relative 'character'"
  output.puts "require_relative 'trie'"
  output.puts ""

  output.puts "class UnicodeData"
  output.puts "  include Singleton"
  output.puts "  attr_reader :cp_hash, :trie, :alias_hash"
  output.puts ""
  output.puts "  def initialize"
  output.puts "    @cp_hash = Hash.new"
  output.puts "    @trie = Trie.new"
  output.puts "    @alias_hash = Hash.new"

  # Store unicode character objects in an array
  output.puts "\t@charlist = []"
  i = 0
  for each in data
    t = each.strip.split(";", -1)
    if t.length != 8
      raise "Data file is not formatted as expected or was read incorrectly."
    end
    # charinit = character_format % [t[0], t[1], t[2], t[3], t[4], t[5], t[6], t[7]]
    output.puts "\t@charlist[#{i}] = " + character_format % [t[0], t[1], t[2], t[3], t[4], t[5], t[6], t[7]]
    output.puts cp_hash_format % [t[0], "@charlist[#{i}]"]
    output.puts trie_open % [t[1], "@charlist[#{i}].codepoint"]
    if !t[4].empty?
      output.puts alias_hash_format % [t[4], "@charlist[#{i}].name"]
    end
    if !t[5].empty?
      output.puts alias_hash_format % [t[5], "@charlist[#{i}].name"]
    end
    if !t[6].empty?
      output.puts alias_hash_format % [t[6], "@charlist[#{i}].name"]
    end
    if !t[7].empty?
      output.puts alias_hash_format % [t[7], "@charlist[#{i}].name"]
    end
    i += 1
  end
  output.puts "  end"
  output.puts "end"
  output.close unless output == nil
end


parse_file
