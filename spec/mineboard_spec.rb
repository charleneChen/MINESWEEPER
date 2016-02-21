require 'rspec'
require '../lib/mineboard'

describe 'Mineboard' do

  mineboard = Mineboard.new(3, 5)
  row = mineboard.row
  column = mineboard.column
  squares = mineboard.squares

  it 'the row of mineboard should equals to 3' do
    expect(row).to eql(3)
  end

  it 'the column of mineboard should equals to 5' do
    expect(column).to eql(5)
  end

  it 'the initial value of mineboard should equals to EMPTY_CHARACTER' do
    row.times do |x|
      column.times do |y|
        expect(squares[x][y].value).to eql(Mineboard::EMPTY_CHARACTER)
      end
    end

  end

  it 'set up mineboard with lines should change the value of a empty square to mine correctly' do
    lines = [['.', '.', '.', '.' ,'*'],['.', '.', '.', '.', '.'],['.', '.', '.', '.', '.']]
    mineboard.setupMine(lines)
    expect(squares[0][4].value).to eql(Mineboard::MINE_CHARACTER)
  end

  it 'set up mineboard with valid characters should return true' do
    lines = [['.', '.', '.', '.', '*'],['.', '.', '.', '.', '.'],['.', '.', '.', '.', '.']]
    success = mineboard.setupMine(lines)
    expect(success).to eql(true)
  end

  it 'set up mineboard with invalid characters should return false' do
    lines = [['.', '.', '.', '.' ,'3'],['.', '.', '.', '.', '.'],['.', '.', '.', '.', '.']]
    success = mineboard.setupMine(lines)
    expect(success).to eql(false)
  end

  it 'should check if two squares are adjacent' do
    square_1 = squares[0][1]
    square_2 = squares[1][2]
    isAdjacent = mineboard.isAdjacent(square_1, square_2)
    expect(isAdjacent).to eql(true)
  end

  it 'should check if the value of a square is MINE_CHARACTER with a given x and y ' do
    lines = [['.', '.', '.', '.', '*'],['.', '.', '.', '.', '.'],['.', '.', '.', '.', '.']]
    mineboard.setupMine(lines)
    isMine = mineboard.isMine(0, 4)
    expect(isMine).to eql(true)
  end

  it 'should return an array of mines after set up mineboard' do
    lines = [['.', '.', '.', '.', '*'],['.', '.', '.', '.', '.'],['.', '.', '.', '.', '.']]
    mineboard.setupMine(lines)
    mines = mineboard.getMines
    expect(mines.size).to eql(1)
    expect(mines[0].class).to eql(Square)
    expect(mines[0].value).to eql(Mineboard::MINE_CHARACTER)
  end

  it 'should return the number of adjacent mines of a square' do
    lines = [['.', '.', '.', '.', '*'],['.', '.', '.', '.', '.'],['.', '.', '.', '.', '.']]
    mineboard.setupMine(lines)
    mines = mineboard.getMines
    square = squares[0][3]
    numberMines = mineboard.getNumberAdjacentMines(mines, square)
    expect(numberMines).to eql(1)
  end

  it 'should get all the number of adjacent mines of mineboard with given lines' do
    lines = [['.', '.', '.', '.', '*'],['.', '.', '.', '.', '.'],['.', '.', '.', '.', '.']]
    mineboard.setupMine(lines)
    mineboard.solution
    expect(squares[0][0].value).to eql(0)
    expect(squares[0][1].value).to eql(0)
    expect(squares[0][2].value).to eql(0)
    expect(squares[0][3].value).to eql(1)
    expect(squares[0][4].value).to eql(Mineboard::MINE_CHARACTER)
    expect(squares[1][0].value).to eql(0)
    expect(squares[1][1].value).to eql(0)
    expect(squares[1][2].value).to eql(0)
    expect(squares[1][3].value).to eql(1)
    expect(squares[1][4].value).to eql(1)
    expect(squares[2][0].value).to eql(0)
    expect(squares[2][1].value).to eql(0)
    expect(squares[2][2].value).to eql(0)
    expect(squares[2][3].value).to eql(0)
    expect(squares[2][4].value).to eql(0)
  end

end