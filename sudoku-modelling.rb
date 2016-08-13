class Sudoku
	def initialize(board_string)
		return "Wrong length" if board_string.length != 81
	  	
	  	@rows = Array.new(9) {(1..9).to_a}
	  	@cols = Array.new(9) {(1..9).to_a}
	  	@blocks = Array.new(9) {(1..9).to_a}

	  	p board_string
	  	@board=[]
	  	board_string.chars.each{|x| @board<< [x.to_i,[],[]]}
	  	@board = Array.new(9) {@board.shift(9)}

						#The below line performs the same as this:
	  				  	# for i in 0..8
					  	# 	for j in 0..8
					  	# 		@board[i][j][1] = {"block" => ((i/3)*3)+(j/3)}
					  	# 	end
					  	# end
		@board.each_index{|i| @board[i].each_index{|j| @board[i][j][1]= ((i/3)*3)+(j/3)}}
		p @board[0][0][1]
	  	p @board[0][0][1]
	  	
	  	print_board
	  	row_possibles  	
	  	col_possibles
	  	block_possibles
	  	square_possibles
	  	# complete_wipe_square_possibles	
	  	p @board
	end

	def print_board
		display=""
		for i in 0...9
			for j in 0...9
				display<<@board[i][j][0].to_s
				display<<" "
			end
			display<< "\n"
		end
		puts display
	end

	def row_possibles
		@board.each_index{|i| @board[i].each_index{|j| @rows[i].delete(@board[i][j][0]) if @board[i][j][0]!=0}}
		puts "rows"
		p @rows
		puts ""
	end

	def col_possibles
		@board.each_index{|i| @board[i].each_index{|j| @cols[j].delete(@board[i][j][0]) if @board[i][j][0]!=0}}
		puts "cols"
		p @cols
		puts ""
	end

	def block_possibles		
		@board.each_index{|i| @board[i].each_index{|j| @blocks[@board[i][j][1]].delete(@board[i][j][0]) if @board[i][j][0]!=0}}
		puts "blocks"
		p @blocks
		puts ""
	end

	def square_possibles
		@board.each_index{|i| @board[i].each_index{|j| @board[i][j][2] = @rows[i] &	@cols[j] & @blocks[@board[i][j][1]]}}
		@board.each_index{|i| @board[i].each_index{|j| @board[i][j][2]=[] if @board[i][j][0]!=0}}
		p @board
	end


	def fill_blanks
		# @sum=0
		@board.each_index{|i| @board[i].each_index{|j| @board[i][j][0] = @board[i][j][2][0] if @board[i][j][2].length==1}}
		# @board.each_index{|i| @board[i].each_index{|j| @sum+=@board[i][j][2]}}
		# p @sum
	end

	# 	def complete_wipe_square_possibles
	# 	@board.each_index{|i| @board[i].each_index{|j| @board[i][j][2]=[] if @board[i][j][0]!=0}}
	# 	 # p @board
	# end


	def solve!
# puts "solving"
# 		@board.each_index{|i| @board[i].each_index{|j| p @board[i][j][0]}}
# puts "finished solving"
		10.times do
		fill_blanks
	  	row_possibles  	
	  	col_possibles
	  	block_possibles
	  	square_possibles
	  	print_board
	  end


	  	# @board.each{|x| p x[1]}
	  	# square=[]
	  	# @board.each {|i| square<<[i,[],[]]}
	  	# p square
	  	# @board[0].each do |x|
	  	# 	@square[0]<<x.to_i
	  		
	  	# end
	  	# # {|x| @board[0][]<<x.to_i}
	  	# # p @board[0]
	  	# p @square
	  	# zxc=[1,2,3,4]
	  	# p zxc

	#   	@board[0][0]=[@board[0][0],"gdsfxgzxfg"]
	#   p @board
	# p   @board[0][0]
	end

	  # Returns a string representing the current state of the board
	  # Don't spend too much time on this method; flag someone from staff
	  # if you are.

end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt').last.chomp
p board_string.length
game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"
game.solve!

# game.print_board