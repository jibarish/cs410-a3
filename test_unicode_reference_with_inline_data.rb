require 'test/unit'
require_relative 'reference'
require_relative 'unicode_data'

class ReferenceTestWithInlinedData < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @reference = Reference.instance
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  def test_codepoint_lookup
    null = @reference.character("NULL")
    assert(null == "0000")
  end

  def test_name_lookup
    null = @reference.name("0000")
    assert(null == "NULL")
  end

  def test_major_category_lookup
    null = @reference.majorCategory("0000")
    assert(null == "C")
  end

  def test_category_lookup
    null = @reference.category("0000")
    assert(null == "Cc")
  end

  def test_name_lookup_correction_alias
    name = @reference.name("01A2")
    assert(name == "LATIN CAPITAL LETTER GHA")
  end

  def test_codepoint_lookup_abbreviation_alias
    cp = @reference.character("NUL")
    assert(cp == "0000")
  end

  def test_codepoint_lookup_alternate_alias
    cp = @reference.character("BYTE ORDER MARK")
    assert(cp == "FEFF")
  end

  def test_codepoint_lookup_correction_alias
    cp = @reference.character("LATIN CAPITAL LETTER GHA")
    assert(cp == "01A2")
  end

  def test_codepoint_lookup_figment_alias
    cp = @reference.character("SINGLE GRAPHIC CHARACTER INTRODUCER")
    assert(cp == "0099")
  end

  def test_codepoint_lookup_control_char_no_alias
    assert_raise(Reference::AmbiguousName) do
      cp = @reference.character("<control>")
    end
  end

  def test_codepoint_lookup_bad_char
    assert_raise(Reference::NoSuchCharacter) do
      cp = @reference.character("Gobbledygook")
    end
  end

  def test_name_lookup_bad_char
    assert_raise(Reference::NoSuchCharacter) do
      cp = @reference.name("Gobbledygook")
    end
  end

  def test_major_category_lookup_bad_char
    assert_raise(Reference::NoSuchCharacter) do
      cp = @reference.majorCategory("Gobbledygook")
    end
  end

  def test_category_lookup_bad_char
    assert_raise(Reference::NoSuchCharacter) do
      cp = @reference.category("Gobbledygook")
    end
  end

end
