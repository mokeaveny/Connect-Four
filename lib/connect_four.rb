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
	def initialize
		@board = []
		@player1 = Player.new
		@player2 = Player.new
		@current_player_name = "Player 1"
		@current_player = @player1 
		@won = false
		@last_play_row = 0
		@last_play_col = 0
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
			print "#{@current_player_name} please select a number to drop your token on: "
			column_drop = gets.chomp
			column_drop = column_drop.to_i

			if column_drop > 0 && column_drop < 8
				valid_choice = true # They are able to place it in thay column
				placed = false # Until the loop finds a place to put the token
				column_drop = column_drop - 1
				
				if @board[0][column_drop] != "|   |"
					valid_choice = false
					puts "That column is full! try another"
					next
				end
							
				while placed == false
					for i in (5).downto(0) # Iterates downwards. Starts at 5 then goes to 0. This means it starts at the bottom of the column
						if @board[i][column_drop] == "|   |"
							@board[i][column_drop] = "| #{@current_player.colour} |"
							@last_play_row = i
							@last_play_col = column_drop
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
			@current_player_name = "Player 2"
		else
			@current_player = @player1
			@current_player_name = "Player 1"
		end
	end

	def check_vertical
		check_symb = "| #{@current_player.colour} |"
		for i in 0..2
			current_check = []
			current_check.append(@board[i][@last_play_col])
			current_check.append(@board[i+1][@last_play_col])
			current_check.append(@board[i+2][@last_play_col])
			current_check.append(@board[i+3][@last_play_col])
			
			if current_check.all?(check_symb) # If all of the elements of current check are | R | or | Y | then return true
				@won = true
				# Maybe change @won to true here?
			end
		end
	end

	def check_horizontal
		check_symb = "| #{@current_player.colour} |"
		for i in 0..3
			current_check = []
			current_check.append(@board[@last_play_row][i])
			current_check.append(@board[@last_play_row][i+1])
			current_check.append(@board[@last_play_row][i+2])
			current_check.append(@board[@last_play_row][i+3])

			if current_check.all?(check_symb)
				@won = true
			end
		end
	end
		
	def check_diagonal
		check_symb = "| #{@current_player.colour} |"
		visited = [] # Once visited append to here and delete from to_check
		to_check = [[@last_play_row, @last_play_col]] # Always checks the first element. The first element is then removes when all the possibilities of that coordinate ha been checked.
		while to_check.any? # While there are still elements in the to_check array
			current_row = to_check[0][0] # First element is deleted at the end of the check
			current_col = to_check[0][1] # First element is deleted at the end of the check

			# Checks lower right diagonal
			if ((current_row + 3) <= 5) && ((current_col + 3) <= 6)
				current_check = []
				current_check.append(@board[current_row][current_col])
				current_check.append(@board[current_row + 1][current_col + 1])
				current_check.append(@board[current_row + 2][current_col + 2])
				current_check.append(@board[current_row + 3][current_col + 3])
				
				if current_check.all?(check_symb)
					@won = true
				end
					
				if visited.include?([current_row + 1, current_col + 1]) == false && to_check.include?([current_row + 1, current_col + 1]) == false
					to_check.append([current_row + 1, current_col + 1])
				end

         if visited.include?([current_row + 2, current_col + 2]) == false && to_check.include?([current_row + 2, current_col + 2]) == false
					to_check.append([current_row + 2, current_col + 2])
				end
				
			  if not visited.include?([current_row + 3, current_col + 3]) == false && to_check.include?([current_row + 3, current_col + 3]) == false
					to_check.append([current_row + 3, current_col + 3])
				end
			end
			
			#Checks upper right diagonal
			if ((current_row - 3) >= 0) && ((current_col + 3) <= 6) 
				current_check = []
				current_check.append(@board[current_row][current_col])
				current_check.append(@board[current_row - 1][current_col + 1])
				current_check.append(@board[current_row - 2][current_col + 2])
				current_check.append(@board[current_row - 3][current_col + 3])
					
				if current_check.all?(check_symb)
					@won = true
				end
					
				if not visited.include?([current_row - 1, current_col + 1]) == false && to_check.include?([current_row - 1, current_col +1]) == false
					to_check.append([current_row - 1, current_col + 1])
				end

				if not visited.include?([current_row - 2, current_col + 2]) == false && to_check.include?([current_row - 2, current_col +2]) == false
					to_check.append([current_row - 2, current_col + 2])
				end

				if not visited.include?([current_row - 3, current_col + 3]) == false && to_check.include?([current_row - 3, current_col +3]) == false
					to_check.append([current_row - 3, current_col + 3])
				end
			end
			
			# Checks lower left diagonal
			if ((current_row + 3) <= 5) && ((current_col - 3) >= 0)
				current_check = []
				current_check.append(@board[current_row][current_col])
				current_check.append(@board[current_row + 1][current_col - 1])
				current_check.append(@board[current_row + 2][current_col - 2])
				current_check.append(@board[current_row + 3][current_col - 3])

				if current_check.all?(check_symb)
					@won = true
				end
					
				if not visited.include?([current_row + 1, current_col - 1]) == false && to_check.include?([current_row + 1, current_col -1]) == false
					to_check.append([current_row + 1, current_col - 1])
				end

				if not visited.include?([current_row + 2, current_col - 2]) == false && to_check.include?([current_row + 2, current_col -2]) == false
					to_check.append([current_row + 2, current_col - 2])
				end

				if not visited.include?([current_row + 3, current_col - 3]) == false && to_check.include?([current_row + 3, current_col -3]) == false
					to_check.append([current_row + 3, current_col - 3])
				end
			end

			# Checks upper left diagonal
			if ((current_row - 3) >= 0) && ((current_col - 3) >= 0)
				current_check = []
				current_check.append(@board[current_row][current_col])
				current_check.append(@board[current_row - 1][current_col - 1])
				current_check.append(@board[current_row - 2][current_col - 2])
				current_check.append(@board[current_row - 3][current_col - 3])
					
				if current_check.all?(check_symb)
					@won = true
				end

				if not visited.include?([current_row - 1, current_col - 1]) == false && to_check.include?([current_row - 1, current_col -1]) == false
					to_check.append([current_row - 1, current_col - 1])
				end				
					
				if not visited.include?([current_row - 2, current_col - 2]) == false && to_check.include?([current_row - 2, current_col -2]) == false
					to_check.append([current_row - 2, current_col - 2])
				end

				if not visited.include?([current_row - 3, current_col - 3]) == false && to_check.include?([current_row - 3, current_col -3]) == false
					to_check.append([current_row - 3, current_col - 3])
				end
			end	

		#Append current row and current column to visited
		#Delete first element from to_check
		visited.append([current_row, current_col])
		to_check.slice!(0)
	
		end
	end
	

	def play
		create_board
		while @won == false
			display_board
			turn
			check_vertical
			check_horizontal
			check_diagonal
			change_player
		end
		display_board
		change_player # Have to change the player back as they win checks are performed before the player is changed
		if @won == true
			puts "Well done #{@current_player_name}! You won the game!"
		end
	end

end	

new_game = Game.new
new_game.play