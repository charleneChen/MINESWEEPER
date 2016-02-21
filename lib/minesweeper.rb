require_relative 'mineboard'

class Minesweeper

  # ------------------------------------------------ First Step ------------------------------------------------

  # if input two invalid number, this part will continue asking to input two valid number;
  # if the number of inputs is not equal to 2, this part will continue asking to input two valid number
  # with error information
  def acceptTwoIntegers
    begin
      @row = 0
      @column = 0

      # two integers stand for the number of lines and columns of the mineboard respectively
      print 'Please input two integers n and m (where 0 < n,m < 100), eg. 3 5 -- '
      two_integers = STDIN.gets.chomp.split

      if two_integers.size != 2
        puts("#{two_integers.size} input detected, please input 2 numbers.")
      else
        @row = two_integers[0].to_i
        @column = two_integers[1].to_i

        # first initialize the mineboard with the number of rows, columns and empty characters
        @mineboard = Mineboard.new(@row, @column)
      end

    end while @row <= 0 || @row >= 100 || @column <= 0 || @column >= 100
  end

  # ------------------------------------------------ Second Step ------------------------------------------------

  # read lines from input and then return lines
  # the input should match row * column
  # otherwise, this part will continue asking to input matched data
  def readLines

    puts "Please input #{@row} lines x #{@column} columns characters that represent squares:"

    lines_size = 0
    lines = []

    while lines_size != @row
      line = STDIN.gets.chomp

      if line.size != @column
        puts "#{@column} characters per line, please try again."

        # get all mines from input lines
        puts "Please input #{@row} lines x #{@column} columns characters that represent squares:"

        lines_size = 0
        lines = []
        next
      end

      lines << line.split(//)
      lines_size += 1
    end
    return lines
  end

  def acceptLines
    # set up mineboard with valid characters
    # when input invalid characters, this part will continue asking input valid characters
    begin
      lines = readLines
      if not @mineboard.setupMine(lines)
        puts "Invalid character detected, please input #{Mineboard::EMPTY_CHARACTER} and #{Mineboard::MINE_CHARACTER} "
      end
    end while not @mineboard.setupMine(lines)
  end

  # ------------------------------------------------ Final Step ------------------------------------------------

  def run
    acceptTwoIntegers
    acceptLines
    # Mineboard#solution - return the number of adjacent mines
    @mineboard.solution
    @mineboard.printBoard
  end
end




minesweeper = Minesweeper.new
minesweeper.run
