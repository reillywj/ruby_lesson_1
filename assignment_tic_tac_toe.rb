#assignment_tic_tac_toe.rb
#Tic Tac Toe
#Player Chooses where to go.
#Computer plays (where player has not played)
#Keeps playing until winner or no more spaces to go

require 'pry'
# Show tic tac toe board
def show_board(board_hash)
  five_spaces = "#{" "*5}"
  five_dashes = "#{"-"*5}"
  empty_line = "#{five_spaces}|#{five_spaces}|#{five_spaces}"
  divider_line = "#{five_dashes}+#{five_dashes}+#{five_dashes}"
  pipe = "  |  "
  row1 = "  #{board_hash["1"]}#{pipe}#{board_hash["2"]}#{pipe}#{board_hash["3"]}  "
  row2 = "  #{board_hash["4"]}#{pipe}#{board_hash["5"]}#{pipe}#{board_hash["6"]}  "
  row3 = "  #{board_hash["7"]}#{pipe}#{board_hash["8"]}#{pipe}#{board_hash["9"]}  "
  puts empty_line
  puts row1
  puts empty_line
  puts divider_line
  puts empty_line
  puts row2
  puts empty_line
  puts divider_line
  puts empty_line
  puts row3
  puts empty_line
end

def ask_player_for_move(possible_positions_hash, inputted_value = "")
  print "Where would you like to go? Possible positions are: #{possible_positions_hash.keys}: "
  position = gets.chomp
  if possible_positions_hash.keys.include?(position)
    position #returns position
  else
    tell_invalid("position. Inputted #{position}.")
    ask_player_for_move(possible_positions_hash, position)
  end
end

def tell_invalid(message)
  puts "Invalid #{message}"
end

def return_marker_positions(x_or_o_marker, board_hash)
  board_hash.select {|location, marker| marker.downcase == x_or_o_marker.downcase}
end

def is_winner?(x_or_o_marker, board_hash, winning_position_array)
  #Checks to see if the marker passed is a winner or not.
  truth_array = []
  winning_position_array.each_index {|index| truth_array[index] = ((winning_position_array[index] & return_marker_positions(x_or_o_marker, board_hash).keys).count == 3)}
  truth_array.include?(true)
end

def return_possible_positions(board_hash)
  board_hash.select {|position, marker| marker =~ /[1-9]/}
end

def best_position_array(board_hash, winning_position_array, marker_to_block)
  marker_position_array = return_marker_positions(marker_to_block, board_hash).keys
  best_pos_array = []
  location_array = []
  winning_position_array.each_index {|index| location_array[index] = ((winning_position_array[index] & marker_position_array).count == 3)}
  
  winning_position_array.each_index {|index| }
  if position_hash.values.count(marker_to_block) == 2
    position_hash.select {|position, marker| marker =~ /[1-9]/}.keys.first
  else
    false
  end
end

def select_board(board_hash, array_of_positions_to_select)
  board_hash.select {|position, value| array_of_positions_to_select.include?(position)}
end

def tell_player(message)
  puts message
end

def initialize_board(winning_position_array)
  winning_position_array.first(3).flatten
end

WINNING_POSITIONS = [["1","2","3"], ["4","5","6"], ["7","8","9"],["1","4","7"],["2","5","8"],["3","6","9"],["1","5","9"],["3","5","7"]]

player_winner = false
computer_winner = false
position_board_array = initialize_board(WINNING_POSITIONS)
tic_tac_toe_board = [position_board_array, position_board_array].transpose.to_h

begin
  system "clear"
  tell_player("#{"-"*20}YOUR MOVE#{"-"*20}")
  show_board(tic_tac_toe_board)
  possible_positions = return_possible_positions(tic_tac_toe_board)
  tell_player("-"*49)
  player_move = ask_player_for_move(possible_positions)
  tic_tac_toe_board[player_move] = "X"
  player_winner = is_winner?("X", tic_tac_toe_board, WINNING_POSITIONS)
  unless player_winner
    possible_positions = return_possible_positions(tic_tac_toe_board)
    computer_move = possible_positions.keys.sample
    tic_tac_toe_board[computer_move] = "O"
    computer_winner = is_winner?("O", tic_tac_toe_board, WINNING_POSITIONS)
  end
end until return_possible_positions(tic_tac_toe_board).empty? || player_winner || computer_winner

system "clear"
tell_player("#{"-"*20}GAME OVER#{"-"*20}")
if player_winner
  tell_player("The computer doesn't know how to play. You won!")
elsif computer_winner
  tell_player("The computer got lucky. You lost!!!")
else
  tell_player("It's a tie.")
end
show_board(tic_tac_toe_board)