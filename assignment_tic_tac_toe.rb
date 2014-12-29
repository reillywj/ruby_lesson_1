#assignment_tic_tac_toe.rb
#Tic Tac Toe
#Player Chooses where to go.
#Computer plays (where player has not played)
#Keeps playing until winner or no more spaces to go


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
    ask_player_for_move(possible_positions, position)
  end
end
def tell_invalid(message)
  puts "Invalid #{message}."
end
def return_marker_positions(x_or_o_marker, board_hash)
  board_hash.select {|location, marker| marker.downcase == x_or_o_marker.downcase}
end

def array_include_three_values(array, value1, value2, value3)
  array.include?(value1) && array.include?(value2) && array.include?(value3)
end

def is_winner?(x_or_o_marker, board_hash)
  #Checks to see if the marker passed is a winner or not.
  marker_key_array = return_marker_positions(x_or_o_marker, board_hash).keys
  horizontal_win = array_include_three_values(marker_key_array, '1', '2', '3') || array_include_three_values(marker_key_array,'4', '5', '6') || array_include_three_values(marker_key_array,'7', '8', '9')
  vertical_win = array_include_three_values(marker_key_array,'1', '4', '7') ||  array_include_three_values(marker_key_array,'2','5','8') || array_include_three_values(marker_key_array,'3','6','9')
  diagonal_win = array_include_three_values(marker_key_array, '1', '5', '9') || array_include_three_values(marker_key_array,'3', '5', '7')
  return horizontal_win || vertical_win || diagonal_win
end

def return_possible_positions(board_hash)
  board_hash.select {|position, marker| marker =~ /[1-9]/}
end

def tell_player(message)
  puts message
end

player_winner = false #Initializes player is not winner yet
computer_winner = false #Initializes computer is not winner yet
position_board_array = Array.new(9) #Creates a blank array
position_board_array.each_index {|index| position_board_array[index] = (index+1).to_s} #creates an array of the tic tac toe positions as a string to be used to convert into a hash
tic_tac_toe_board = [position_board_array, position_board_array].transpose.to_h #creates initial board to use in the rest of this game

begin
show_board(tic_tac_toe_board) #Show board to player before asking where they'd like to go.
possible_positions = return_possible_positions(tic_tac_toe_board) #Calculate possible positions hash to let player know what's available.
player_move = ask_player_for_move(possible_positions)#Ask player and receive position where they'd like to go.
tic_tac_toe_board[player_move] = "X" #Place player's move in the board hash
player_winner = is_winner?("X", tic_tac_toe_board) #See if player is a winner based on last move
unless player_winner #Unless player is the winner, let computer play.
  possible_positions = return_possible_positions(tic_tac_toe_board) #Determines possible positions on the board to choose from.
  computer_move = possible_positions.keys.sample #Computer currently picks at random from possible positions
  tic_tac_toe_board[computer_move] = "O" #Place move into board hash
  computer_winner = is_winner?("O", tic_tac_toe_board) #See if computer is the winner.
end
end until return_possible_positions(tic_tac_toe_board).empty? || player_winner || computer_winner #Keep playing until there are no more places to play(tie) or there is a winner.

tell_player("#{"-"*20}GAME OVER#{"-"*20}")
if player_winner
  tell_player("The computer doesn't know how to play. You won!")
elsif computer_winner
  tell_player("The computer got lucky. You lost!!!")
else
  tell_player("It's a tie.")
end
show_board(tic_tac_toe_board)