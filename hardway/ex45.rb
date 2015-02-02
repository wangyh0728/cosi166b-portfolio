require_relative 'ex45-help.rb'

left = Room.new(true, ["book"], ["glasses"])
right = Room.new(true, ["cups"],["book"])


player = Player.new
puts "Welcome!"
puts "You're in a room with two doors, left and right, and a pair of glasses on the desk."
puts "What would you like to do? open the left door, open the right door or pick up the glasses"


while true 
	puts '>'
	action = gets.chomp
	if action == "open the left door" 
		if left.lock == true
			puts "Door is locked, and you need glasses first"
		else
			left.open()
			s = gets.chomp
			if s == yes 
				player.pickup("book")
				right.unlock()
			end
		end
	elsif action == "open the right door"
		if right.ifLocked()
			puts "Door is locked, and you need a book first"
		else
			right.open()
			s = gets.chomp
			if s == yes 
				player.pickup("cups")
				puts "You win!"
			end
		end
	elsif action == "pick up the glasses" 
		player.items.push("glasses")
		left.unlock()
	elsif action == "return" 
		puts "You are at the start place"			
	else 
		puts "unrecognized"
	end
end
			