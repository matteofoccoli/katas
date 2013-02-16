require 'test/unit'

class BinaryCounter 
  attr_reader :value

  def initialize(bits)
    @value = []
    (0...bits).each {|i| @value[i] = 0}
  end

  def increment
    i = 0
    while i < @value.length && @value[i] == 1
      @value[i] = 0
      i = i + 1
    end
    @value[i] = 1
  end
end

class BinaryCounterTest < Test::Unit::TestCase
  def setup
    @counter = BinaryCounter.new 8
  end

  def test_returns_8_bits_counter
    assert_equal [0, 0, 0, 0, 0, 0, 0, 0], @counter.value
  end
  
  def test_one_increment
    @counter.increment
    
    assert_equal [1, 0, 0, 0, 0, 0, 0, 0], @counter.value
  end 

  def test_two_increments
    @counter.increment
    @counter.increment

    assert_equal [0, 1, 0, 0, 0, 0, 0, 0], @counter.value
  end

  def test_four_increments
    @counter.increment
    @counter.increment
    @counter.increment
    @counter.increment

    assert_equal [0, 0, 1, 0, 0, 0, 0, 0], @counter.value
  end  
end
