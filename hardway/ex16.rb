filename = ARGV.first

puts "file exists? #{File.exists?(filename)}"

puts "We're going to erase #{filename}"
puts "If you don't want that, hit CTRL-C (^C)."
puts "If not, hit RETURN."

$stdin.gets

target = open(filename, 'w')

puts "Truncating the file"
target.truncate(0)

puts "Plz type three lines"

print "line 1: "
line1 = $stdin.gets.chomp
print "line 2: "
line2 = $stdin.gets.chomp
print "line 3: "
line3 = $stdin.gets.chomp

puts "Write to the file."

target.write(line1)
target.write("\n")
target.write(line2)
target.write("\n")
target.write(line3)
target.write("\n")

puts "And finally, we close it."
target.close
