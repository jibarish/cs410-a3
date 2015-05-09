require 'enumerator'
require_relative 'character'

class Characters
  include Enumerable
  attr_reader :charlist

  def initialize
    # Read in data
    data = File.open("UnicodeDataClean.txt", "r"){ |f| f.read.split("\n") }

    # Store unicode character objects in an array
    @charlist = []
    for each in data
      t = each.strip.split(";", -1)
      if t.length != 7
        raise "Data file is not formatted as expected or was read incorrectly."
      end
      @charlist << Character.new(t[0], t[1], t[2], t[3], t[4], t[5], t[6])
    end
  end

  def each
    @charlist.each { |i| yield i }
  end
end
