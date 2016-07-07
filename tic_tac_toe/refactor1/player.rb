class Player
	attr_accessor :name, :marker
	def initialize(args)
		@name = args[:name]
		@marker = args[:marker]
	end
end
