require_relative 'square'

class Mineboard

  MINE_CHARACTER = '*'
  EMPTY_CHARACTER = '.'

  attr_accessor :row, :column, :squares

  def initialize(row, column)
    @row = row
    @column = column
    @squares = []

    @row.times do |x|
      columns = []
      @column.times do |y|
        columns << Square.new(x, y, EMPTY_CHARACTER)
      end
      @squares << columns
    end
  end

  # set up mines based on input lines
  # go through lines, if character equals to MINE_CHARACTER then change square value in the appropriate position
  # in not, leave unchanged because mineboard has been initialized with EMPTY_CHARACTER
  # return success true or false
  def setupMine(lines)
    success = true
    lines.each_with_index do |line, x|
      invalidCharacter = false

      line.each_with_index { |square, y|

        # checking invalid character
        if square != MINE_CHARACTER && square != EMPTY_CHARACTER
          invalidCharacter = true
          break
        end

        # changing square value to MINE_CHARACTER
        if square == MINE_CHARACTER
          @squares[x][y].value = MINE_CHARACTER
        end
      }

      if invalidCharacter
        success = false
        break
      end

    end

    return success
  end

  # given index x and y, checking the square in this position whether its value is MINE_CHARACTER or not
  def isMine(x, y)
    if @squares[x][y].value == MINE_CHARACTER
      return true
    else
      return false
    end
  end

  # given two squares, checking if is adjacent
  def isAdjacent(square, mine)
    x = (square.x - mine.x).abs
    y = (square.y - mine.y).abs
    if x < 2 && y < 2
      return true
    else
      return false
    end
  end

  # go through all squares in mineboard
  # return an array of mines, then the positions of mines can be utilised
  def getMines
    mines = []
    @row.times do |x|
      @column.times do |y|
        if isMine(x, y)
          mines << @squares[x][y]
        end
      end
    end
    return mines
  end

  # given an array of mines and a square, finding the number of adjacent mines of this square
  # return the number of adjacent mines of this square
  def getNumberAdjacentMines(mines, square)
    count = 0
    mines.each do |mine|
      if isAdjacent(square, mine)
        count += 1
      end
    end
    return count
  end

  # print solution
  def printBoard
    @row.times do |x|
      @column.times do |y|
        print @squares[x][y].value
      end
      print "\n"
    end
  end

  def solution
    mines = getMines
    @row.times do |x|
      @column.times do |y|
        square = @squares[x][y]

        # when square value equals to EMPTY_CHARACTER true
        unless square.value == MINE_CHARACTER
          numberMines = getNumberAdjacentMines(mines, square)
          # change square value from RMPTY_CHARACTER to the number of adjacent mines
          square.value = numberMines
        end
      end
    end
  end

end