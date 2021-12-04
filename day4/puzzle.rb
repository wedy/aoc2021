# https://adventofcode.com/2021/day/4

module SquidBingo

  def self.winner?(grid)
    (0...5).each do |x|
      if (grid[0][x] == "X" &&
          grid[1][x] == "X" &&
          grid[2][x] == "X" &&
          grid[3][x] == "X" &&
          grid[4][x] == "X") ||
          (grid[x][0] == "X" &&
           grid[x][1] == "X" &&
           grid[x][2] == "X" &&
           grid[x][3] == "X" &&
           grid[x][4] == "X")
        return true
      end
    end
    false
  end

  def self.call_play(*game, number_called)
    game.each do |grid|
      grid.each do |row|
        row.each_with_index do |num, index|
          if num == number_called
            row[index] = 'X'
          end
        end
      end
    end
  end

  def self.no_of_games(data)

    numbers = data.shift.strip.split(",")
    data.shift # the line

    games = Hash.new
    game_no = 0
    data.each do |row|
      if row.strip == ""
        game_no += 1
        next
      end

      if games[game_no].nil?
        games[game_no] = Array.new
      end

      games[game_no] << row.split(" ")
    end
    [numbers, games]
  end

  def self.sum_unmarked_numbers(grid)
    sum = 0
    grid.each do |row|
      row.each do |num|
        sum += num.to_i unless num == 'X'
      end
    end
    sum
  end
end

# first puzzle
numbers, games = SquidBingo.no_of_games(File.readlines('puzzle.txt'))

numbers.each do |number|
  games.each_with_index do |game, index|
    SquidBingo.call_play(game[1], number)
    if SquidBingo.winner?(game[1])
      p "first result : #{SquidBingo.sum_unmarked_numbers(game[1]) * number.to_i}"
      exit
    end
  end
end

# second puzzle
numbers, games = SquidBingo.no_of_games(File.readlines('puzzle.txt'))

numbers.each do |number|
  games.each_with_index do |game, index|
    SquidBingo.call_play(game[1], number)
    if SquidBingo.winner?(game[1])
      if games.size == 1
        p "second result : #{SquidBingo.sum_unmarked_numbers(game[1]) * number.to_i}"
        exit
      end
      games.delete(game[0])
    end
  end
end

