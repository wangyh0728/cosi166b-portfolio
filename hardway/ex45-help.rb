class Room
	def initialize(lock, items, unlockList)
		@lock = lock
		@items = items
		@unlockList = unlockList
	end

	def Room.unlock()
		@lock = false
	end

	def self.ifLocked()
		return lock
	end

	def Room.open() 
		print "Here is a ", items[0]
		puts " Do you want to pick it up? "
		puts ">"
	end

end

class Player
	def Player.initialize 
		@items = []
	end

	def Player.pickUp(item)
		@items.push(item)
	end
end
