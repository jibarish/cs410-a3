require_relative 'reference'

reference = Reference.new

puts reference.name("0010")
puts reference.majorCategory("0010")
puts reference.category("0010")

puts reference.name("01A2")  # This should return the correction alias

require 'test/unit'
require_relative 'reference'

class ReferenceTest < Test::Unit::TestCase

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
  	reference = Reference.new
    null = reference.character("NULL")
    assert(null == "0000")
  end

  def test_name_lookup
  	reference = Reference.new
    null = reference.name("0000")
    assert(null == "NULL")
  end

  def test_major_category_lookup
  	reference = Reference.new
  	null = reference.majorCategory("0000")
  	assert(null == "C")
  end

  def test_category_lookup
  	reference = Reference.new
  	null = reference.category("0000")
  	assert(null == "Cc")
  end
end
