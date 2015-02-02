def whatIf(people, dog, cat)
	if people < cat
		puts "too many cats"
	elsif people < dog
		puts "too many dogs"
	else 
		puts "proper numbers"
	end
end

		
whatIf(1,2,3)