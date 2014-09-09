#!/usr/bin/env ruby

# Find longest palindrome in provided string - Solution 1
# Time O(n^2), Space: O(n^2)
module LongestPalindrome1
  def self.find(string)
    return if string.nil?
    return '' if string.empty?
    chars, palindromes, found, longest = initiate(string)

    find_double_palindromes(chars, palindromes, found, longest)
    find_longer_palindromes(chars, palindromes, found, longest)
  end

  private

  def self.initiate(string)
    palindromes = Array.new(string.size) { Array.new(string.size) }
    # single characters are palindromes
    0.upto(string.size - 1) { |i| palindromes[i][i] = 1 }

    chars = string.chars

    found = Array.new(string.size)
    found[0] = 1
    found[1] = 1

    longest = chars[0]

    [chars, palindromes, found, longest]
  end

  def self.palindrome?(from, to, chars, palindromes)
    palindromes[from + 1][to - 1] == 1 && chars[from] == chars[to]
  end

  def self.find_double_palindromes(chars, palindromes, found, longest)
    0.upto(chars.size - 1) do |i|
      next unless chars[i] == chars[i + 1]
      palindromes[i][i + 1] = 1
      longest = chars.slice(i, 2).join('')
      found[2] = 1
    end
    longest
  end

  def self.find_longer_palindromes(chars, palindromes, found, longest)
    3.upto(chars.size) do |l|
      0.upto(chars.size - l) do |i|
        j = i + l - 1
        next unless palindrome?(i, j, chars, palindromes)
        palindromes[i][j] = 1 && found[l] = 1
        longest = chars.slice(i, l).join('')
      end
      break unless found[l - 1] || found[l - 2]
    end
    longest
  end
end

# Find longest palindrome in provided string - Simple solution
# Time: O(n^2) Space: O(1)
module LongestPalindrome2
  def self.check(string)
    longest = string.byteslice(0, 1)
    0.upto(string.size - 2) do |i|
      # single center
      tmp_longest = find_longest(string, i, i)
      longest = tmp_longest if tmp_longest.size > longest.size

      # double
      tmp_longest = find_longest(string, i, i + 1)
      longest = tmp_longest if tmp_longest.size > longest.size
    end

    longest
  end

  def self.match(string, l, r)
    string.chars[l] == string.chars[r]
  end

  def self.find_longest(string, l, r)
    return '' if l != r && string.chars[l] != string.chars[r]

    tmp_l = l
    tmp_r = r

    while tmp_l > -1 && tmp_r < string.size && match(string, tmp_l, tmp_r)
      l = tmp_l
      r = tmp_r

      tmp_l -= 1
      tmp_r += 1
    end

    string.byteslice(l, r - l + 1)
  end
end

puts <<-responses

#{LongestPalindrome1.find(nil)} == nil
#{LongestPalindrome1.find(nil).nil? }

#{LongestPalindrome1.find('')} == ''
#{LongestPalindrome1.find('') == ''}

#{LongestPalindrome1.find('Palinildrome')} =='linil'
#{LongestPalindrome1.find('Palinildrome') == 'linil' }
#{LongestPalindrome2.check('Palinildrome') == 'linil' }


#{LongestPalindrome1.find('Palinnildrome')} =='dlinnild'
#{LongestPalindrome1.find('Padlinnildrome') == 'dlinnild' }
#{LongestPalindrome2.check('Padlinnildrome') == 'dlinnild' }

responses
