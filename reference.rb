require 'singleton'
require_relative 'unicode_data'
require_relative 'trie'
require_relative 'characters'
require_relative 'alias_lookup_table'

class Reference
  include Singleton
  attr_reader :codepoint_to_data, :name_to_data, :alias_to_name

  def initialize(data_source=UnicodeData.instance)
    # Master storage object
    # - referenced by internal data structures (codepoint_to_data, name_to_data)

    @codepoint_to_data = data_source.hash
    @name_to_data = data_source.trie
    @alias_to_name = AliasLookupTable.instance
  end

  def name(codepoint)
    # -> String
    # Map a codepoint to the corresponding name.

    val = @codepoint_to_data[codepoint]
    val.correction.empty? ? val.name : val.correction
  end

  def character(name)
    # -> Codepoint
    # Map a string representing a name, or an alias, to a codepoint.

    @name_to_data[@alias_to_name.check_alias(name)]
  end

  def majorCategory(codepoint)
    # -> String
    # Map a codepoint to a string of length 1-3 that represents its major category.

    @codepoint_to_data[codepoint].major_category
  end

  def category(codepoint)
    # -> String
    # Map a codepoint to a string of length 2 that represents its category.

    @codepoint_to_data[codepoint].minor_category
  end
end
