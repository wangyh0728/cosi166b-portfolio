def print_two(*args)
	puts *args.class
  arg1 = args
  puts "arg1: #{arg1}"
end
print_two("Zed")