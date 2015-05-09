require 'test/unit'
require_relative 'trie'

class MyTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  def test_get
    a = Trie.new
    a.push("A COOL STRING", 123)
    assert(a.get("A COOL STRING") == 123)
  end

  def test_push
    a = Trie.new
    a.push("A COOL STRING", 123)
    assert(a.has_key?("A COOL STRING"))
  end

  def test_insert_similar_string
    a = Trie.new
    a.push("A COOL STRING", 123)
    a.push("A COOL STRINGG", 321)
    assert(a.has_key?("A COOL STRING"))
    assert(a.has_key?("A COOL STRINGG"))
  end

  def test_retrieve_similar_string
    a = Trie.new
    a.push("A COOL STRING", 123)
    a.push("A COOL STRINGG", 321)
    assert(a.get("A COOL STRING") == 123)
    assert(a.get("A COOL STRINGG") == 321)
  end
end