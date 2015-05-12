class Trie

  def initialize
    @root = nil
  end

  def push(key, value)
    key = key.to_s
    return nil if key.empty?
    @root = push_recursive(@root, key, 0, value)
    value
  end
  alias_method :[]=, :push

  def has_key?(key)
    key = key.to_s
    return false if key.empty?
    !(get_recursive(@root, key, 0).nil?)
  end

  def get(key)
    key = key.to_s
    return nil if key.empty?
    node = get_recursive(@root, key, 0)
    node ? node.last : nil
  end
  alias_method :[], :get


  private

  class Node
    attr_accessor :left, :right, :middle, :parent, :char, :value, :end

    def initialize(char, value)
      @char = char
      @value = value
      @parent = @left = @right = @middle = nil
      @end = false
    end

    def last?
      @end == true
    end
  end

  def push_recursive(node, string, index, value)
    char = string[index]
    node = Node.new(char, value) if node.nil?
    if (char < node.char)
      node.left = push_recursive(node.left, string, index, value)
    elsif (char > node.char)
      node.right = push_recursive(node.right, string, index, value)
    elsif (index < string.length-1)
      node.middle = push_recursive(node.middle, string, index+1, value)
    else
      node.end = true
      node.value = value
    end
    node
  end

  def get_recursive(node, string, index)
    return nil if node.nil?
    char = string[index]
    if (char < node.char)
      return get_recursive(node.left, string, index)
    elsif (char > node.char)
      return get_recursive(node.right, string, index)
    elsif (index < string.length-1)
      return get_recursive(node.middle, string, index+1)
    else
      return node.last? ? [node.char, node.value] : nil
    end
  end
end
