require_relative 'characters'
require_relative 'trie'
require_relative 'unicode_data'
require 'singleton'

class Reference
  #include Singleton
  attr_reader :hash, :trie

  def initialize(data_source=Characters.instance)
    # Master storage object
    # - referenced by internal data structures (hash, trie)
    
    @hash = data_source.hash
    @trie = data_source.trie
  end

  def name(codepoint)
    # -> String
    # Map a codepoint to the corresponding name.

    val = @hash[codepoint]
    val.correction.empty? ? val.name : val.correction
  end

  def character(name)
    # -> Codepoint
    # Map a string representing a name, or an alias, to a codepoint.

    @trie[name]
  end

  def majorCategory(codepoint)
    # -> String
    # Map a codepoint to a string of length 1-3 that represents its major category.

    @hash[codepoint].major_category
  end

  def category(codepoint)
    # -> String
    # Map a codepoint to a string of length 2 that represents its category.

    @hash[codepoint].minor_category
  end
end
