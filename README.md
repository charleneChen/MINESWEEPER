# MINESWEEPER with Ruby
__Command-line based, Object-oriented application__

1. Accept the size of a mineboard
2. Next, accept lines configuration of mines in that board

__Note:__ some errors handling are included

__For example__,

- invalid characters, only * and .
- wrong number of characters, should match the size of row * column
- wrong number of size, only accept two integers

### Before running
- make sure you have installed Ruby-2.2.2
- make sure you have installed Rspec

## How to Run
cd lib/

ruby minesweeper.rb

## How to Test
cd spec/

rspec square_spec.rb

rspec mineboard_spec.rb