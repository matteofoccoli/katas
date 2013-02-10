require 'test/unit'

module Sorting
  
  def self.insertion_sort(array)
    return [] if array.empty?
    (1..array.length - 1).each do |j|
      key = array[j]
      i = j - 1
      while i >= 0 && array[i] > key
	array[i + 1] = array[i] # Move element ahead
	i = i - 1
      end
      array[i + 1] = key
    end
    return array
  end

  def self.merge_sort(array)
    return merge_sort_rec(array, 0, array.length - 1)
  end 

  def self.merge_sort_rec(array, p, r)
    if p < r
      q = (r + p) / 2
      merge_sort_rec(array, p, q)
      merge_sort_rec(array, q + 1, r)
      merge(array, p, q, r)
    end
  end
  
  def self.merge(array, p, q, r)
    left = array[p..q]
    right = array[q + 1..r]
    left << max_fixnum 
    right << max_fixnum
    i = 0
    j = 0
    (p..r).each do |k|
      if left[i] <= right[j]
	array[k] = left[i]
	i = i + 1
      else
	array[k] = right[j]
	j = j + 1
      end
    end
    return array
  end

  def self.max_fixnum
    return Float::MAX
  end
end

class SortingTest < Test::Unit::TestCase
  def test_insertion_sort_one_element_array
    assert_equal [1], Sorting.insertion_sort([1])
  end

  def test_insertion_sort_empty_array
    assert_equal [], Sorting.insertion_sort([])
  end

  def test_insertion_sort
    assert_equal [1, 2, 3, 4, 5], Sorting.insertion_sort([5, 4, 3, 1, 2])
  end

  def test_merge
    assert_equal [1, 2, 3, 4], Sorting.merge([1, 4, 2, 3], 0, 1, 3)
  end

  def test_merge_sort
    assert_equal [1, 3, 33, 546, 999], Sorting.merge_sort([546, 3, 33, 1, 999])
  end
end
