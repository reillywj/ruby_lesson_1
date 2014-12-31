# Black Jack

# 1. Ask player for name
# 2. Provide current bank
# 3. Ask player to provide bet (no more than bank)
# 4. Deal cards to player and dealer, show dealer's top card to player, show all player's cards and current total.
# 5. Calculate total of player's cards. If player's cards sum to 21, player wins; else ask player to hit or stay
# 6. Repeat until player's cards equals 21 (auto win), is greater than 21 (bust), or player choses to stay.
# 7. If player stays, dealer is dealt cards every 0.5 seconds until greater than or equal to 17.
# 8. Check if dealer > 21 (player wins),
# => if dealer is equal to player count (tie; player bank is equal to player bank),
# => if dealer total > player (dealer wins; player bank is equal to bank - bet)
# => else (player wins; player bank is equal to bank + bet)
# 9. If player bank > 0, ask player to keep playing
# => if keep playing loop through @ #2
# => else exit loop
#10. Tell player game over
#11. Tell player how much they can go home with

require 'pry'

def say(message)
  puts "#{message}"
end

def say_title(title)
  hyphen_s = "-"*10
  say "#{hyphen_s}#{title}#{hyphen_s}\n"
end

def tell_invalid(invalid_entry, message)
  puts "#{invalid_entry} is an invalid entry. #{message}."
end

def get_player_name
  say "What's your name: "
  name = gets.chomp
  if name.empty? || name =~ /[1-9]/
    tell_invalid(name, "Try again")
    get_player_name
  else
    name
  end
end

def initialize_player_bank
  500
end

def initialize_keep_playing
  true
end

def sleep_for(seconds)
  sleep seconds
end

def reset_deck(suits, cards)
  suits.product(cards)
end

def get_player_bet(bank)
  say "You have #{bank}. Enter bet: "
  bet = gets.chomp
  if bet.to_i.to_s == bet
    bet_as_integer = bet.to_i
    if bet_as_integer <= 0
      tell_invalid(bet_as_integer, "Must be greater than 0")
      get_player_bet bank
    elsif bet_as_integer > bank
      tell_invalid(bet_as_integer, "Must be less than or equal to #{bank}")
      get_player_bet bank
    else
      bet_as_integer
    end
  else
    tell_invalid(bet, "Must be an integer")
    get_player_bet bank 
  end
end

def show_all_cards(card_array)
  say "#{card_array}"
end

def show_first_card(card_array)
  say "#{card_array[0]} #{["unknown suit", "unknown value"]}"
end

def hit_me?
  say "hit: 'y' or stay: 'n'"
  answer = gets.chomp.downcase
  if answer == 'y'
    true
  elsif answer == 'n'
    false
  else
    tell_invalid(answer, "Must enter y to hit or n to stay")
    hit_me?
  end
end

def repeat?(message)
  say "Would you like to #{message}? y/n"
  answer = gets.chomp.downcase
  if answer == 'y'
    true
  elsif answer == 'n'
    false
  else
    tell_invalid(answer, "Must input y or n")
    repeat?(message)
  end
end

def calculate_value_of(cards)
  value_of_cards = 0
  number_of_aces = 0
  cards.each do |card|
    card_type = card[1]
    value_of_card_type = CARD_VALUE_HASH[card_type]
    if (card_type == "ace")
      number_of_aces += 1
    else
      value_of_cards += value_of_card_type
    end
  end
  if number_of_aces > 0
    for i in 1..number_of_aces do
      if value_of_cards + (11 * (number_of_aces - i + 1)) > 21
        value_of_cards += 1
      else
        value_of_cards += 11
      end
    end
  end
  value_of_cards
end

def show_cards_player_playing(player_cards, dealer_cards)
  say_title "Your Turn"
  say_title "Your Cards"
  show_all_cards player_cards
  say_value_of_cards("Your", player_cards)
  say_title "Dealer's Cards"
  show_first_card dealer_cards
end

def say_value_of_cards(person, cards)
  say "#{person} hand is worth #{calculate_value_of(cards)}."
end

def show_cards_dealer_playing(player_cards, dealer_cards)
  say_title "Dealer's Turn"
  say_title "Your cards"
  show_all_cards player_cards
  say_value_of_cards("Your", player_cards)
  say_title "Dealer's cards"
  show_all_cards dealer_cards
  say_value_of_cards("The Dealer's", dealer_cards)
end

def deal_card(deck)
  deck.delete(deck.sample)
end

def say_current_bank(bank_amount)
  say "You currently have #{bank_amount} in your bank."
end

def sleep_and_clear_system(time)
  sleep_for 0.0 #time
  system "clear"
end

def say_player_and_dealer_cards(player_cards, dealer_cards)
  say "You have #{player_cards}. The dealer has #{dealer_cards}."
end

#-------------------------------------------------------------------------------

SUITS = ["hearts", "diamonds", "spades", "clubs"]
CARDS = ["ace","2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king"]
#note: manually adjust value of ace if bust to 1
CARD_VALUE_HASH = {"ace" =>11, "2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6, "7" => 7, "8" => 8, "9" => 9, "10" => 10, "jack" => 10, "queen" => 10, "king" => 10}

play_again = initialize_keep_playing

sleep_and_clear_system 0.5
say_title "Black Jack"
player_name = get_player_name
sleep_and_clear_system 1.0
say "Hello, #{player_name}! We're about to play some Black Jack."

begin
  sleep_and_clear_system 2.0
  player_bank = initialize_player_bank
  keep_playing = initialize_keep_playing
  say_title "#{player_name}, let's play some Black Jack"
  begin
    deck = reset_deck(SUITS, CARDS)
    player_cards = []
    dealer_cards = []
    player_value = 0
    dealer_value = 0
    hit_variable = true
    bust_variable = false
    
    say_title "What's your bet?"
    current_bet = get_player_bet player_bank
    say "You bet #{current_bet}."
    
    #deal cards
    player_cards << deal_card(deck)
    dealer_cards << deal_card(deck)
    player_cards << deal_card(deck)
    dealer_cards << deal_card(deck)
    player_value = calculate_value_of(player_cards)
    dealer_value = calculate_value_of(dealer_cards)
    say_title "Dealing Cards..."
    sleep_and_clear_system 5.0
    
    #Player hit or stay?
    until player_value >= 21 || !hit_variable
      system "clear"
      show_cards_player_playing(player_cards, dealer_cards)
      say_title "Hit or stay?"
      hit_variable = hit_me?
      if player_value < 21 && hit_variable
        player_cards << deal_card(deck)
        show_cards_player_playing(player_cards, dealer_cards)
        player_value = calculate_value_of(player_cards)
      end
    end
    
    sleep_and_clear_system 0.5
    show_cards_dealer_playing(player_cards, dealer_cards)
    if player_value < 21 && dealer_value < 17
      until dealer_value >= 17
        sleep_and_clear_system 0.25
        dealer_cards << deal_card(deck)
        dealer_value = calculate_value_of(dealer_cards)
        show_cards_dealer_playing(player_cards, dealer_cards)
        sleep_and_clear_system 0.5
      end
    end
    
    #Shouldn't need following, but adding in redundancy for time being.
    say_title("Hand Over")
    #Award winnings
    if player_value > 21
      say_player_and_dealer_cards(player_cards, dealer_cards)
      say "You busted with #{player_value}. You lost #{current_bet}."
      player_bank -= current_bet
      say_current_bank player_bank
    elsif (player_value < dealer_value) && (dealer_value <= 21)
      say_player_and_dealer_cards(player_cards, dealer_cards)
      say "The dealer beat you #{dealer_value} to #{player_value}. You lost #{current_bet}."
      player_bank -= current_bet
      say_current_bank player_bank
    elsif player_value == 21
      say_player_and_dealer_cards(player_cards, dealer_cards)
      say "You hit #{player_value} BLACK JACK! You won #{current_bet}."
      player_bank += current_bet
      say_current_bank player_bank
    elsif player_value > dealer_value
      say_player_and_dealer_cards(player_cards, dealer_cards)
      say "You beat the dealer #{player_value} to #{dealer_value}. You won #{current_bet}!"
      player_bank += current_bet
      say_current_bank player_bank
    elsif dealer_value > 21
      say_player_and_dealer_cards(player_cards, dealer_cards)
      say "The dealer busted with #{dealer_value}. You won #{current_bet}!"
      player_bank += current_bet
      say_current_bank player_bank
    elsif player_value == dealer_value
      say_player_and_dealer_cards(player_cards, dealer_cards)
      say "It's a tie: #{dealer_value} to #{player_value}. You did not lose any money!"
    else
      #Shouldn't need
      say_title "Something's wrong in the win/loss logic."
      show_cards_dealer_playing(player_cards, dealer_cards)
      say player_bank
    end
    sleep_for 2.0
    
    #Play again?
    if player_bank == 0
      say_title("NO MONEY!")
      say_current_bank player_bank
      say "You are out of money in your bank."
      keep_playing = false
    else
      say_title "What's next?"
      say_current_bank player_bank
      keep_playing = repeat? "keep playing"
    end
  end while keep_playing
  say_title("GAME OVER")
  say "You left the table with #{player_bank} in your pocket."
  play_again = repeat? "play again"
  if play_again
    say_title("#{player_name}, you are about to play again.")
    say_title "LOADING..."
    sleep_for 1.0
    say_title "LOADING......"
    sleep_and_clear_system 2.0
  end
end while play_again

say_title "Done Playing" 
say "Thanks for playing Black Jack. Have a nice day."