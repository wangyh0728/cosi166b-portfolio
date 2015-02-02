#Modules provides methods that can be used across multiple classes (libraries)

module MyStuff
    def self.apple() #or Mystuff.apple()
        puts "I AM APPLES!"
    end

    # this is just a variable
    TANGERINE = "Living reflection of a dream"
end

MyStuff.apple()
puts MyStuff::TANGERINE