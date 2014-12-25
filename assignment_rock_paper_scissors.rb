#assignment_rock_paper_scissorts.rb
#play rock paper scissors
#Rock> scissors
#Scissors> Paper
#Paper> Rock
#Ask best of <enter odd number>
#Input player 1's value (R/P/S)
#Input player 2's value (R/P/S)
#Compare
#Declare winner/tie
#Keep track of score

require 'pry'

def ask_best_of(limit)
  print "Best of how many games? Input odd number at least 1 but less than #{limit}. => "
  answer = gets.chomp
  answer_to_i = answer.to_i
  if answer.downcase == answer.upcase
    if answer_to_i <= 0
      tell_invalid("entry. Must be > 0.")
      ask_best_of(limit)
    elsif answer_to_i > limit
      tell_invalid("entry. Must by <= #{limit}.")
      ask_best_of(limit)
    elsif answer_to_i.even?
      tell_invalid("number. Must be odd.")
      ask_best_of(limit)
    else
      answer_to_i
    end
  else
    tell_invalid("entry. Try again.")
    ask_best_of(limit)
  end
end

def tell_invalid(message)
  puts "#{"*"*3}Invalid #{message}#{"*"*3}"
end

def ask_player_rps(player)
  print "#{player}, Rock (R), Paper (P), or Scissors (S)? => "
  answer = gets.chomp.downcase
  if answer =~ /[rps]/
    answer
  else
    tell_invalid("entry.")
    ask_player_rps(player)
  end
end

def check_score(number_of_games, player_score)
  #Return true if player_score is enough to win or not
  #Return false if not enough wins to be winner yet
  (number_of_games / 2 + 1) <= player_score
end

def player_wins?(player_entry, other_entry)
  (player_entry == 'r' && other_entry == 's') || (player_entry == 's' && other_entry == 'p') || (player_entry == 'p' && other_entry == 'r')
end

def tell_round_winner(entry1, entry2, entry1_name, entry2_name, score1, score2)
  if entry1 == entry2
    puts "It's a tie this round."
  elsif player_wins?(entry1, entry2)
    wins_round(entry1_name)
  else
    wins_round(entry2_name)
  end
end

def wins_round(name)
  puts "#{name} wins this round!"
end

def player_in_the_lead (score1, score2, name1, name2)
  if score1 == score2
    puts "It's a tie. #{score1} to #{score2}."
  elsif score1 > score2
    tell_winning_score(score1, score2, name1)
  else
    tell_winning_score(score2, score1, name2)
  end
end

def tell_winning_score(winning_score, losing_score, winner_name)
  puts "#{winner_name} is winning #{winning_score} to #{losing_score}."
end

def tell_winner(name, rounds, winning_score, losing_score)
  puts "#{name} wins best of #{rounds}:  #{winning_score} to #{losing_score}."
end
  
def message(input)
  puts "#{"-"*21}#{input}#{"-"*21}"
end

player1_score = 0
player2_score = 0
is_winner = false
player1 = "Player 1"
player2 = "Player 2"
round_limit = 9

message("Rock, Paper, Scissors")
number_of_rounds = ask_best_of(round_limit)

begin
  message("#{"-"*6}Best of #{number_of_rounds}#{"-"*6}")
  player1_answer = ask_player_rps(player1)
  player2_answer = ask_player_rps(player2)
  tell_round_winner(player1_answer, player2_answer, player1, player2, player1_score, player2_score)
  
  if player_wins?(player1_answer, player2_answer)
    player1_score += 1
  elsif player_wins?(player2_answer, player1_answer)
    player2_score += 1
  else
    #do nothing
  end
  
  is_winner = check_score(number_of_rounds, player1_score) || check_score(number_of_rounds, player2_score)
  player_in_the_lead(player1_score, player2_score, player1, player2)
end while !is_winner

message("#{"-"*6}GAME OVER#{"-"*6}")
if player1_score > player2_score
  tell_winner(player1, number_of_rounds, player1_score, player2_score)
else
  tell_winner(player2, number_of_rounds, player2_score, player1_score)
end

puts "Thanks for playing Rock, Paper, Scissors!"