def smallest_spread(file_path)
  day = 0
  spread = nil
  IO.foreach(file_path) {|line| 
    if /^\s+(\d+)\s+(\d+)\s+(\d+)/ =~ line
      min = $3.to_i
      max = $2.to_i
      if !spread || max - min < spread
        spread = max - min 
        day = $1.to_i
      end
    end
  }
  return day
end

describe 'Get smallest spread' do
  
  it 'within one day' do
    day = smallest_spread('single.dat')
    
    day.should eq(1)
  end
  
  it 'within two days' do
    day = smallest_spread('two_days.dat')
    
    day.should eq(1)
  end
  
end
