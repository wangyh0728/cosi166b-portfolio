class MyClass 
	def self.greet
		puts "I am a class method"
	end
end

MyClass.greet

class MyClass2 
	def greet
		puts "I am a class method"
	end
end

c = MyClass2.new
c.greet

class MyClass3
	def self.greet(save) #class method: combining the class name and the method name
		puts "I am a class method"
		@save = save #class instance variable: only one copy, can be changed
	end

	def self.get_save
		@save
	end

	def greet #instance method
		puts "Hello Class #{MyClass3.get_save}"
end

