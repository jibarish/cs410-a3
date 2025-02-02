require_relative 'reference'
require_relative 'characters'

reference = Reference.new

require 'test/unit'
require_relative 'reference'

class ReferenceTestWithCharactersSingleton < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @reference = Reference.new
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  def test_codepoint_lookup
  	#reference = Reference.new
    null = @reference.character("NULL")
    assert(null == "0000")
  end

  def test_name_lookup
  	#reference = Reference.new
    null = @reference.name("0000")
    assert(null == "NULL")
  end

  def test_major_category_lookup
  	#reference = Reference.new
  	null = @reference.majorCategory("0000")
  	assert(null == "C")
  end

  def test_category_lookup
  	#reference = Reference.new
  	null = @reference.category("0000")
  	assert(null == "Cc")
  end
end
