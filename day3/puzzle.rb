# https://adventofcode.com/2021/day/3

module BinaryDiagnostic
  def self.calculate(data)
    arr = Hash.new

    data.each_with_index do |row, index|
      row.strip.split("").each_with_index do |char, i|

        if arr[i].nil?
          arr[i] = Hash.new
        end

        if arr[i][1].nil?
          arr[i][1] = 0
        end

        if arr[i][0].nil?
          arr[i][0] = 0
        end

        arr[i][1] += 1 if char.to_i == 1
        arr[i][0] += 1 if char.to_i == 0
      end
    end

    stringArr = Array.new
    arr.each do |x|
      if x[1][1].to_i > x[1][0].to_i
        stringArr << 1
      else
        stringArr << 0
      end
    end

    gamma = stringArr.join("").to_i(2)

    stringArr = Array.new
      arr.each do |x|
        if x[1][1].to_i < x[1][0].to_i
          stringArr << 1
        else
          stringArr << 0
      end
    end

    epsilon = stringArr.join("").to_i(2)

    epsilon * gamma
  end

  def self.last_standing(original)
    data = original
    length = data.first.split("").length-1
    (0...length).each do |x|
      data = self.get_list(data, "gamma", x)
      if data.size == 1
        break
      end
    end
    oxygen = data.first.to_i(2)

    data = original
    (0...length).each do |x|
      data = self.get_list(data, "epsilon", x)
      if data.size == 1
        break
      end
    end

    co2 = data.first.to_i(2)

    oxygen * co2
  end

  def self.get_list(data, type, bit)
    arr = Hash.new

    data.each_with_index do |row, index|
      row.strip.split("").each_with_index do |char, i|

        if arr[i].nil?
          arr[i] = Hash.new
        end

        if arr[i][1].nil?
          arr[i][1] = 0
        end

        if arr[i][0].nil?
          arr[i][0] = 0
        end

        arr[i][1] += 1 if char.to_i == 1
        arr[i][0] += 1 if char.to_i == 0
      end
    end

    if type == 'gamma'
      if arr[bit][1].to_i >= arr[bit][0].to_i
        winner = 1
      else
        winner = 0
      end
    else
      if arr[bit][1].to_i < arr[bit][0].to_i
        winner = 1
      else
        winner = 0
      end
    end

    result = Array.new
    data.each do |row|
      if row[bit].to_i == winner
        result << row.strip
      end
    end

    result
  end
end

# first puzzle
firstResult = BinaryDiagnostic.calculate(File.readlines('puzzle.txt'))
p "first result: #{firstResult}"


secondResult = BinaryDiagnostic.last_standing(File.readlines('puzzle.txt'))
p "second result: #{secondResult}"
