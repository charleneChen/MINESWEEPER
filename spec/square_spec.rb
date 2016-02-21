require 'rspec'
require '../lib/square'

describe 'Square' do

  square = Square.new(0, 1, '.')

  it 'the x axis of square should equals to 0' do
    expect(square.x).to eql(0)
  end

  it 'the y axis of square should equals to 1' do
    expect(square.y).to eql(1)
  end

  it 'the value of square should equals to .' do
    expect(square.value).to eql('.')
  end
end