#!/usr/bin/env ruby

# Given a string s and a dictionary of words dict, determine if s can be
# segmented into a space-separated sequence of one or more dictionary words.
#
# For example, given
# s = "brownfoxjumps",
# dict = ["brown", "jumps", "fox"].
#
# Return true because "brownfoxjumps" can be segmented as "brown fox jumps".
# O(n^3)
module WordBreakNaive
  def self.word_break?(string, dict)
    return true if string.empty?

    dict.each do |word|
      next if word.size > string.size
      if string.slice(0, word.size) == word
        word_break?(string.slice(word.size, string.size - word.size), dict)
        return true
      end
    end
    false
  end
end

puts WordBreakNaive.word_break?('brownfoxjumps', %w(brown fox jumps))
