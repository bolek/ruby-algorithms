#!/usr/bin/env ruby

# Reverse Polish Notation parser
module RPN
  @operations = {}

  def self.register(operation, procedure)
    @operations[operation] = procedure
  end

  def self.eval(tokens)
    stack = []
    tokens.each do |token|
      stack.push(parse(token, stack))
    end
    stack.pop
  end

  private

  def self.parse(token, stack)
    case
    when @operations.key?(token)
      operate(token, stack)
    when token.is_a?(Integer)
      token
    else
      fail "No idea how to parse #{el}"
    end
  end

  def self.operate(operator, stack)
    a = stack.pop
    b = stack.pop
    @operations[operator].call(b, a)
  end
end

# Sample use
RPN.register('+', ->(a, b) { a + b })
RPN.register('-', ->(a, b) { a - b })
RPN.register('*', ->(a, b) { a * b })
RPN.register('/', ->(a, b) { a / b })

puts RPN.eval([2, 5, '+', 6, '*']) == 42
