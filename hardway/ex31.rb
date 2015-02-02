sym = true
while sym
	puts "Please choose from door 1 and door 2: "
	print ">"
	door = gets.chomp.to_i

	if door == 1 
		puts "There's a giant bear here eating a cheese cake.  What do you do?"
  		puts "1. Take the cake."
  		puts "2. Scream at the bear."
  		print '>'

  		choice = gets.chomp.to_i
  		if choice == 1 
  			puts "win"
  		else puts "wow"
  		end
  	elsif door == 2
  		puts "You stare into the endless abyss at Cthulhu's retina."
  		puts "1. Blueberries."
  		puts "2. Yellow jacket clothespins."
  		print '>'

  		choice = gets.chomp.to_i
  		if choice != 1 
  			puts "win"
  		else puts "wow"
  		end
  	else 
  		puts "no such choice"
  	end

  	puts "would you like to start over? (T/F)"
  	print ">"
  	if gets.chomp != "T"
  		sym = false
  	end
end

  	

