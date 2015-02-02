hairs = ["brown", "blond", "red"]
eyes = ["brown", "blue", "black"]
weights = [1,2,3,4]
combine = [1, "String", ["a", "array"]]
element = []
combine.each do |x|
	puts "here is #{x} and push into combine"
	element.push(x)
end
print element
puts
for styles in hairs 
	element.push(styles)
end
print element
puts
#until 
i = 0;
until hairs.empty? || i == 4 do
	print hairs.pop + " "
	i += 1
end

puts ++i
puts i +=1

#initalize hash
hash = Hash["user_id", 2, "movie_id", 3, "rating", 5]
puts hash.select{|x| x == "rating"}
puts hash[hash = Hash["user_id", 2, "movie_id", 3, "rating", 5]
hash2 = Has