require 'test/unit'

module Sorting

  def self.insertion_sort(array)
    return array if array.empty?
    (1..array.length - 1).each {|i|
      current = array[i]
      j = i - 1
      while j >= 0 && array[j] > current
      	array[j + 1] = array[j]
      	j = j - 1
      end
      array[j + 1] = current
    }
    return array
  end
  
  def self.merge_sort(array)
    return self.rec_merge_sort(array, 0, array.length - 1)
  end
  
  private
  
  def self.rec_merge_sort(a, p, r)
    if p < r
      q = (p + r) / 2
      self.rec_merge_sort(a, p, q)
      self.rec_merge_sort(a, q + 1, r)
      self.merge(a, p, q, r)
    end
    return a
  end 
  
  def self.merge(a, p, q, r)
    left = a[p..q]
    left << 9999
    right = a[(q + 1)..r]
    right << 9999
    i = 0
    j = 0
    for k in (p..r) 
      if left[i] < right[j]
        a[k] = left[i]
        i = i + 1
      else
        a[k] = right[j]
        j = j + 1
      end
    end
  end
  
end

class SortingTest < Test::Unit::TestCase

  def test_insertion_sort_on_an_empty_array
    assert_equal [], Sorting::insertion_sort([])
  end
  
  def test_insertion_sort
    assert_equal [1, 2, 3, 4, 5], Sorting::insertion_sort([5, 3, 2, 1, 4])
  end
  
  def test_merge_sort
    assert_equal [1, 2, 3, 4, 5], Sorting::merge_sort([5, 3, 2, 1, 4])
  end

end
