class Player
	attr_accessor :colour
	@@number_of_players = 0

	def initialize
	@@number_of_players += 1
	@colour = choose_colour
	end

	def choose_colour
		if @@number_of_players == 1
			@colour = "R"
		elsif @@number_of_players == 2
			@colour = "Y"
		else
			@colour = nil
		end
	end
end

class Game
	attr_reader :board
	def initialize
		@board = []
		create_board
	end

	def create_board
		6.times do
			row = []
			7.times do
				row.append("|   |")
			end
			@board.append(row)
		end
	end
				
	def display_board
		puts("  1     2     3     4     5     6     7")
		@board.each do |row|
			row = row.join(" ")
			puts row
		end
		puts
	end

	def turn
		puts "Please select a number to drop your 

end	

new_game = Game.new
print(new_game.display_board)