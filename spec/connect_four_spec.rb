require './lib/connect_four'

describe Player do
	context "Creating player" do
		context "First player is created" do
			xit "player1 colour should be red" do
				player1 = Player.new
				expect(player1).to have_attributes(:colour => "R")
			end
		end
		context "Second player is created" do
			xit "player2 colour should be yellow" do
				player2 = Player.new
				expect(player2).to have_attributes(:colour => "Y")
			end
		end
		context "Third player is created" do
			xit "player3 colour should be nil" do
				player3 = Player.new
				expect(player3).to have_attributes(:colour => nil)
			end
		end
	end
end

describe Game do
	context "Create the board in the correct format" do
		it "Board should be 6X7 and contain boundaries" do
			new_game = Game.new
			expect(new_game).to have_attributes(:board => [["|   |", "|   |", "|   |", "|   |", "|   |", "|   |", "|   |"],
																										 ["|   |", "|   |", "|   |", "|   |", "|   |", "|   |", "|   |"],
																										 ["|   |", "|   |", "|   |", "|   |", "|   |", "|   |", "|   |"],
																						         ["|   |", "|   |", "|   |", "|   |", "|   |", "|   |", "|   |"],
																										 ["|   |", "|   |", "|   |", "|   |", "|   |", "|   |", "|   |"],
																									   ["|   |", "|   |", "|   |", "|   |", "|   |", "|   |", "|   |"]])
		end
	end
end
