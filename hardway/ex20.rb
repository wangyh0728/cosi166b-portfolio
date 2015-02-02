input_file = ARGV.first

def print_all(f)
  puts f.read
end

def rewind(f)
  f.seek(12) #back to the nth character
end

def print_a_line(line_count, f)
  puts "#{line_count}, #{f.gets.chomp}"
end

current_file = open(input_file)

puts "First let's print the whole file:\n"

print_all(current_file)

puts "Now let's rewind, kind of like a tape."

rewind(current_file)
