# https://adventofcode.com/2021/day/2

module SubmarineNavigator
  def self.where_am_i(directions)
    horizontal = 0
    depth = 0

    directions.each do |data|
      arr = data.split(' ')
      if arr[0] == 'forward'
        horizontal += arr[1].to_i
      elsif arr[0] == 'down'
        depth += arr[1].to_i
      elsif arr[0] == 'up'
        depth -= arr[1].to_i
      end
    end
    horizontal * depth
  end

  def self.where_am_i_2(directions)
    horizontal = 0
    depth = 0
    aim = 0

    directions.each do |data|
      arr = data.split(' ')
      if arr[0] == 'forward'
        horizontal += arr[1].to_i
        depth += (aim * arr[1].to_i)
      elsif arr[0] == 'down'
        aim += arr[1].to_i
      elsif arr[0] == 'up'
        aim -= arr[1].to_i
      end
    end
    horizontal * depth
  end
end

# first puzzle
firstResult = SubmarineNavigator.where_am_i(File.readlines('puzzle.txt'))
p "first result: #{firstResult}"

secondResult = SubmarineNavigator.where_am_i_2(File.readlines('puzzle.txt'))
p "second result: #{secondResult}"
