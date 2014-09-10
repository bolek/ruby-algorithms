#!/usr/bin/env ruby

#Tree
class TreeNode
  attr_accessor :right, :left, :value

  def initialize(value)
    self.value = value
  end

  def to_s
    value
  end
end

# Recursive Tree Traversals
module RecursiveTraversal
  def self.traverse_pre_order(root)
    puts root.value
    RecursiveTraversal.traverse_pre_order(root.left) unless root.left.nil?
    RecursiveTraversal.traverse_pre_order(root.right) unless root.right.nil?
  end

  def self.traverse_in_order(root)
    RecursiveTraversal.traverse_in_order(root.left) unless root.left.nil?
    puts root.value
    RecursiveTraversal.traverse_in_order(root.right) unless root.right.nil?
  end

  def self.traverse_post_order(root)
    RecursiveTraversal.traverse_post_order(root.left) unless root.left.nil?
    RecursiveTraversal.traverse_post_order(root.right) unless root.right.nil?
    puts root.value
  end
end

# Iterative pre-order tree traversals
module IterativeTraversal
  def self.traverse_pre_order(root)
    return if root.nil?
    stack = []

    stack.push(root)
    until stack.empty?
      x = stack.pop
      puts x.value
      stack.push(x.right) if x.right
      stack.push(x.left) if x.left
    end
  end

  def self.traverse_in_order(root)
    return if root.nil?
    stack = []
    i = root
    stack.push(i)

    until stack.empty?
      if i.left
        stack.push(i.left)
        i = i.left
      else
        i = stack.pop
        puts i.value
        if i.right
          stack.push(i.right)
          i = i.right
        end
      end
    end
  end

  def self.traverse_post_order(root)
    return if root.nil?
    stack = []
    stack.push(root)
    prev = nil

    until stack.empty?
      curr = stack.last

      if !prev || prev.left == curr || prev.right == curr
        if curr.left
          stack.push(curr.left)
        elsif curr.right
          stack.push(curr.right)
        else
          puts curr.value
          curr = stack.pop
        end

      elsif curr.left == prev
        if curr.right
          stack.push(curr.right)
        else
          puts curr.value
          curr = stack.pop
        end

      elsif curr.right == prev
        puts curr.value
        curr = stack.pop
      end

      prev = curr
    end
  end
end

tree = TreeNode.new 'F'
tree.left = TreeNode.new 'B'
tree.left.left = TreeNode.new 'A'
tree.left.right = TreeNode.new 'D'
tree.left.right.left = TreeNode.new 'C'
tree.left.right.right = TreeNode.new 'E'
tree.right = TreeNode.new 'G'
tree.right.right = TreeNode.new 'I'
tree.right.right.left = TreeNode.new 'H'

puts 'Recursive in order'
RecursiveTraversal.traverse_in_order(tree)
puts 'Recursive pre order'
RecursiveTraversal.traverse_pre_order(tree)
puts 'Recursive post order'
RecursiveTraversal.traverse_post_order(tree)
puts 'Iterative pre order'
IterativeTraversal.traverse_pre_order(tree)
puts 'Iterative in order'
IterativeTraversal.traverse_in_order(tree)
puts 'Iterative post order'
IterativeTraversal.traverse_post_order(tree)
