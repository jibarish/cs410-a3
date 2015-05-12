require 'test/unit'
require_relative 'unicode'

class UnicodeTestWithInlinedData < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @unicode = Unicode.instance
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.
  def teardown
    # Do nothing
  end


  #
  # Basic functionality
  #

  def test_codepoint_lookup
    null = @unicode.character("NULL")
    assert(null == "0000")
  end

  def test_name_lookup
    null = @unicode.name("0000")
    assert(null == "NULL")
  end

  def test_major_category_lookup
    null = @unicode.majorCategory("0000")
    assert(null == "C")
  end

  def test_category_lookup
    null = @unicode.category("0000")
    assert(null == "Cc")
  end


  #
  # Aliases
  #

  def test_name_lookup_correction_alias
    name = @unicode.name("01A2")
    assert(name == "LATIN CAPITAL LETTER GHA")
  end

  def test_codepoint_lookup_abbreviation_alias
    cp = @unicode.character("NUL")
    assert(cp == "0000")
  end

  def test_codepoint_lookup_alternate_alias
    cp = @unicode.character("BYTE ORDER MARK")
    assert(cp == "FEFF")
  end

  def test_codepoint_lookup_correction_alias
    cp = @unicode.character("LATIN CAPITAL LETTER GHA")
    assert(cp == "01A2")
  end

  def test_codepoint_lookup_figment_alias
    cp = @unicode.character("SINGLE GRAPHIC CHARACTER INTRODUCER")
    assert(cp == "0099")
  end


  #
  # Bad values
  #

  def test_codepoint_lookup_control_char_no_alias
    assert_raise(Unicode::AmbiguousName) do
      cp = @unicode.character("<control>")
    end
  end

  def test_codepoint_lookup_bad_char
    assert_raise(Unicode::NoSuchCharacter) do
      cp = @unicode.character("Gobbledygook")
    end
  end

  def test_name_lookup_bad_char
    assert_raise(Unicode::NoSuchCharacter) do
      cp = @unicode.name("Gobbledygook")
    end
  end

  def test_major_category_lookup_bad_char
    assert_raise(Unicode::NoSuchCharacter) do
      cp = @unicode.majorCategory("Gobbledygook")
    end
  end

  def test_category_lookup_bad_char
    assert_raise(Unicode::NoSuchCharacter) do
      cp = @unicode.category("Gobbledygook")
    end
  end
end
