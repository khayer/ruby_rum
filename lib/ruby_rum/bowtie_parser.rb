module RubyRum
	class BowtieParser
		# The output file is a SAM file so we
		include Enumerable
		def initialize(filename = nil)
			if filename
				@filehandler = ::File.open(filename)
				@list_of_lines = []
				pos = @filehandler.pos
				@filehandler.each do |line|
				unless line.include? "@"
					@list_of_lines << pos
				end
				pos = @filehandler.pos
				end
			else
				@filehandler = nil
				@list_of_lines = []
			end
			@current_iteration = 0

			alias :open :new
		end

		attr_accessor :list_of_lines, :current_iteration

		def next()
			@filehandler.pos = @list_of_lines[@current_iteration]
			if @list_of_lines >= @current_iteration
				@current_iteration += 1
			else 
				return nil
			end
			make_content()
		end

		def make_content()
			
		end

			

		def 


		def non_unique()

		end

		def unique()

		end

	end
end
