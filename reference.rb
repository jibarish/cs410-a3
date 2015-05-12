require 'singleton'
require_relative 'unicode_data'
require_relative 'trie'

class Reference
  include Singleton
  attr_reader :codepoint_to_data, :name_to_codepoint, :alias_to_name

  class AmbiguousName < StandardError; end
  class NoSuchCharacter < StandardError; end

  def initialize(data_source=UnicodeData.instance)
    @codepoint_to_data = data_source.cp_hash
    @name_to_codepoint = data_source.trie
    @alias_to_name = data_source.alias_hash
  end

  def name(codepoint)
    # -> String
    # Map a codepoint to the corresponding name.

    data = checkExistence(@codepoint_to_data[codepoint], codepoint)
    data.correction.empty? ? data.name : data.correction
  end

  def character(name)
    # -> Codepoint
    # Map a string representing a name, or an alias, to a codepoint.

    checkAmbiguity(name)
    official_name = @alias_to_name[name] || name
    checkExistence(@name_to_codepoint[official_name], name)
  end

  def majorCategory(codepoint)
    # -> String
    # Map a codepoint to a string of length 1-3 that represents its major category.

    checkExistence(@codepoint_to_data[codepoint], codepoint).major_category
  end

  def category(codepoint)
    # -> String
    # Map a codepoint to a string of length 2 that represents its category.

    checkExistence(@codepoint_to_data[codepoint], codepoint).minor_category
  end

  def checkExistence(character, request)
    if character == nil
      raise NoSuchCharacter, "No Unicode character corresponds with #{request}."
    end
    character
  end

  def checkAmbiguity(name)
    if name == "<control>"
      raise AmbiguousName, "<control> is an ambiguous Unicode 3.0 name-- instead use an alias."
    end
  end
end
