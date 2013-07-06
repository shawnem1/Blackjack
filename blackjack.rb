def get_total(cards)
	card_values = {"2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6, "7" => 7,
		"8" => 8, "9" => 9, "10" => 10, "J" => 10, "Q" => 10, "K" => 10, "A" => 11}

	#Extract string values from nested array.
	array = cards.map {|e| e[1]}

	#Assign Fixnum values.
	value = []
	array.each {|i| value << card_values[i]}

	#Add values for the sum
	sum = 0
	value.each { |i| sum += i }

	#Account for Aces
	array.select {|e| e == "A"}.count.times do
		if sum > 21 
			sum -= 10
		end
	end
	sum
end

puts 'Enter your name'
name = gets.chomp

puts 'Hello, and welcome to Ruby BlackJack'
puts "Good luck, #{name}!"

#Build a deck of cards
suits = %w(S H C D)
cards = %w(2 3 4 5 6 7 8 9 10 J Q K A)
deck = suits.product(cards)

player_cards = []
dealer_cards = []

#Initial deal
player_cards << deck.sample
deck.delete(player_cards.last)
dealer_cards << deck.sample
deck.delete(dealer_cards.last)
player_cards << deck.sample
deck.delete(player_cards.last)
dealer_cards << deck.sample
deck.delete(dealer_cards.last)

puts "Dealer shows, #{dealer_cards[1]}"
puts ''
puts "Your hand is, #{player_cards} for a total of #{get_total(player_cards)}"
puts ''

h_or_s = ""

puts 'Would you like to 1) Hit or 2) Stand?'

h_or_s = gets.chomp

while h_or_s == "1" do
	player_cards << deck.sample
	deck.delete(player_cards.last)

	if get_total(player_cards) > 21
	puts 'You busted, dealer wins'
	end

	if get_total(player_cards) == 21
	puts 'Blackjack! You win!'
	end
		
	puts "Your hand is, #{player_cards} for a total of #{get_total(player_cards)}"
	puts 'Would you like to 1) Hit or 2) Stand?'
	h_or_s = gets.chomp
	if h_or_s == "2"
	end
end

#Dealer now turns over other card
puts "Dealers shows, #{dealer_cards}, for a total of #{get_total(dealer_cards)}"

#Dealer deals until at least 17
while get_total(dealer_cards) < 17 do
	puts 'Dealer now hits'
	dealer_cards << deck.sample
	deck.delete(dealer_cards.last)
	puts "Dealers shows, #{dealer_cards}, for a total of #{get_total(dealer_cards)}"
	
	if get_total(dealer_cards) > get_total(player_cards) && get_total(dealer_cards) < 21
		puts 'Dealer wins'
	end

	if get_total(dealer_cards) == 21
		puts 'Blackjack! Dealer wins'
	end

	if get_total(dealer_cards) > 21
		puts 'Dealer busts, YOU WIN!'
	end	
end

