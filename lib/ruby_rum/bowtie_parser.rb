module RubyRum
	class BowtieParser
		# The output file is a SAM file so we
		include Enumerable
		def initialize(filename = nil)
			@unique_mapper_pos = []
			@non_unique_mapper_pos = [] 
			@current_iteration = 0
			if filename
				@filehandler = ::File.open(filename)
				@list_of_lines = []
				@list_of_header = []
				position = @filehandler.pos
				@filehandler.each do |line|
					aline = line.split()
					if aline[0] =~ /(@.)/
						@list_of_header << position 
					else
						@list_of_lines << position
					end
					position = @filehandler.pos
				end
				@filehandler.pos = 0
				self.parse()
			else
				@filehandler = nil
				@list_of_lines = []
				@list_of_header = []
			end
			
			

			#alias :open :new
		end

		attr_accessor :list_of_lines, :current_iteration, :list_of_header, :unique_mapper_pos, :non_unique_mapper_pos

		def next()
			@filehandler.pos = @list_of_lines[@current_iteration]
			#if @list_of_lines.length >= @current_iteration
			@current_iteration += 1
			#else 
			#	raise "NO NO NO"
			#end
			make_content()
		end

		def make_content()
			content = RubyRum::BowtieContent.new(@filehandler.read())
		end

		def each &block
			puts "hallo!"
			while (!@filehandler.eof?)
				yield self.next()
			end
		end

		# parse into unique and non-unique mappers
		
		def parse()
			qnames = []
			pos = []
			
			self.each do  |content| 
				puts content.qname
				qnames << content.qname()
				pos << @current_iteration
			end
							
			unless qnames.empty?()
				element1 = qnames.pop()
				pos1 = pos.pop()
				if qnames.include?(element1)
					@non_unique_mapper_pos << pos1
					while qnames.include?(element1)
						ind = qnames.index(element1)
						qnames.delete_at(ind)
						pos2 = pos.delete_at(ind)
						@non_unique_mapper << pos2
					end
				else
					@unique_mapper_pos << pos1
				end
			end
		end
		
		

		def content_at(x)
			if x < 0
				raise "Invalid entry number!"
			end
			if x > @list_of_lines.length()-1
				raise "There are only #{@list_of_lines.length} entries!"
			end
			@current_iteration = x
			self.next()
		end



		def non_unique_to_s()
			entries_to_s(@non_unique_mapper_pos)	
		end

		def unique_to_s()
			entries_to_s(@unique_mapper_pos)
		end

		private
		def entries_to_s(positions)
			out = ""
			for pos in positions
				entry = content_at(pos)
				out += entry.to_s() 
			end

			
		end

	end
end
