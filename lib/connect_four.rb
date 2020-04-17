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
		@player1 = Player.new
		@player2 = Player.new
		@current_player = @player1 
		@won = false
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
		valid_choice = false
		while valid_choice == false
			print "Please select a number to drop your token on: "
			column_drop = gets.chomp
			column_drop = column_drop.to_i

			if column_drop > 0 && column_drop < 8
				valid_choice = true # They are able to place it in thay column
				placed = false # Until the loop finds a place to put the token
				column_drop = column_drop - 1
				
				while placed == false
					for i in (5).downto(0) # Iterates downwards. Starts at 5 then goes to 0. This means it starts at the bottom of the column
						if @board[i][column_drop] == "|   |"
							puts @current_player.colour
							@board[i][column_drop] = "| #{@current_player.colour} |"
							placed = true
							break #Has to break out of the for loop so that all of the column positions don't become that colour
						end
					end
				end

			end
		end
	end
		
	def change_player
		if @current_player == @player1
			@current_player = @player2
		else
			@current_player = @player1
		end
	end

	def play
		create_board
		while @won == false
			display_board
			turn
			change_player
		end
	end

end	

new_game = Game.new
new_game.play