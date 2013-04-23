def smallest_spread(file)
  day = 0
  spread = nil
  IO.foreach(file) {|line|
    match = /^\s+(\d+)\s+(\d+)\s+(\d+)/.match(line)
    if match
      captures = match.captures
      max = captures[1].to_i
      min = captures[2].to_i
      current_spread = max - min
      if !spread || current_spread < spread
        day = captures[0].to_i 
        spread = current_spread
      end
    end
  }
  return day
end

describe 'Smallest temperature spread' do
  it 'within one day' do
    smallest_spread('single.dat').should eq(1)
  end
  
  it 'within two days' do
    smallest_spread('two_days.dat').should eq(1)
  end
end
  