# https://adventofcode.com/2021/day/1

module DepthService

  def self.increase_counter(dataArr)

    counter = 0
    dataArr.each_with_index do |no, index|
      if index > 0 && dataArr[index].to_i > dataArr[index-1].to_i
        counter += 1
      end

    end
    counter
  end

  def self.three_measurement(dataArr)
    collection = Array.new
    dataArr.each_with_index do |data, index|
      collection << (data.to_i + dataArr[index+1].to_i + dataArr[index+2].to_i) unless dataArr[index+1].to_i == 0 || dataArr[index+2].to_i == 0
    end
    collection
  end

end

# first puzzle
firstResult = DepthService.increase_counter(File.readlines('1puzzle.txt'))
p "first result: #{firstResult}"

# second puzzle
dataArr =  DepthService.three_measurement(File.readlines('1puzzle.txt'))
secondResult = DepthService.increase_counter(dataArr)
p "second result: #{secondResult}"
