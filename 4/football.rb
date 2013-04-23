def smallest_goal_difference(file)
  team = ''
  diff = nil
  IO.foreach(file) {|line|
    if /^\s+\d+\.\s+(\w+).+?(\d+)\s+-\s+(\d+)/ =~ line
      for_goals = $2.to_i
      against_goals = $3.to_i
      current_diff = for_goals - against_goals
      if !diff || (current_diff > 0 && diff > current_diff)
        diff = for_goals - against_goals
        team = $1
      end
    end
  }
  return team
end
  
describe 'Football' do
  it 'smallest goal difference for one team' do
    smallest_goal_difference('single_team.dat').should eq 'Arsenal'
  end
  
  it 'smallest goal difference between two teams' do
    smallest_goal_difference('two_teams.dat').should eq 'Arsenal'
  end

  it 'smallest goal difference between many teams' do
    smallest_goal_difference('football.dat').should eq 'Blackburn'
  end  
end