# https://adventofcode.com/2021/day/5

module HydrothermalCalculator

  def self.check_diagonal?(firstX, firstY, secondX, secondY)
    (([firstX,secondX].min)...([firstX,secondX].max)).each do |x|
      break if firstX == secondX || firstY == secondY

      firstX = firstX < secondX ? firstX+1 : firstX-1
      firstY = firstY < secondY ? firstY+1 : firstY-1
    end

    firstX == secondX && firstY == secondY
  end

  def self.insert(axis, x, y)
    if axis["#{x}, #{y}"].nil?
      axis["#{x}, #{y}"] = 1
    else
      axis["#{x}, #{y}"] += 1
    end
  end

  def self.calculate(data, diagonal = 0)
    axis = Hash.new

    data.each do |row|
      coords = row.split(" -> ")
      firstCoord = coords[0].split(',')
      secondCoord = coords[1].split(',')

      firstX = firstCoord[0].to_i
      firstY = firstCoord[1].to_i

      secondX = secondCoord[0].to_i
      secondY = secondCoord[1].to_i

      minX = [firstX, secondX].min
      maxX = [firstX, secondX].max

      minY = [firstY, secondY].min
      maxY = [firstY, secondY].max

      # horizontal
      if firstX == secondX
        (minY..maxY).each do |y|
          self.insert(axis, firstX, y)
        end
      end

      # vertical
      if firstY == secondY
        (minX..maxX).each do |x|
          self.insert(axis, x, firstY)
        end
      end

      # diagonal
      if diagonal == 1 && self.check_diagonal?(firstX, firstY, secondX, secondY)
        self.insert(axis, firstX, firstY)
        self.insert(axis, secondX, secondY)

        (([firstX,secondX].min)...([firstX,secondX].max-1)).each do |x|
          firstX = firstX < secondX ? firstX+1 : firstX-1
          firstY = firstY < secondY ? firstY+1 : firstY-1

          self.insert(axis, firstX, firstY)
        end
      end
    end

    # calculate the highest
    _, value = axis.max_by{|l, v| v}

    counter = 0
    (2..value).each do |x|
      counter += axis.values.count(x)
    end

    counter
  end
end

# first puzzle
firstResult = HydrothermalCalculator.calculate(File.readlines('puzzle.txt'))
p "first result: #{firstResult}"


# second puzzle
secondResult = HydrothermalCalculator.calculate(File.readlines('puzzle.txt'), 1)
p "second result: #{secondResult}"
