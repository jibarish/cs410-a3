require_relative 'characters'
require_relative 'trie'

class Reference
  attr_reader :hash, :trie

  def initialize
    # Master storage object
    # - referenced by internal data structures (hash, trie)
    characters = Characters.new
    
    @hash = Hash.new
    @trie = Trie.new
    for ch in characters
      @hash[ch.codepoint] = ch
      @trie[ch.name] = ch.codepoint
    end
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
