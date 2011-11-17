class BowtieParser<Parser
	# The output file is a SAM file so we
	include Enumerable
	def initialize(filename = nil)
		super(filename)
		avoid_header()
		@start_pos = @filehandler.pos
	end

	def avoid_header()
    line = @filehandler.readline()
    aline = line.split()
    # getting rid off header
    while aline[0] == '@'
      line = @filehandler.readline()
      aline = line.split()
    end
    @filehandler.lineno -= 1
  end

  def make_entry()
  	BowtieEntry.new(@filehandler)
  end



	# parse into unique and non-unique mappers
	def parse()
		@filehandler.pos = 0
		#puts @filehandler.pos
		qnames = []
		pos = []
		self.map  {|content|
			#puts content.qname
			qnames << content.q_name()
			pos << @current_iteration
		}
		while !qnames.empty?()
			element1 = qnames.pop()
			pos1 = pos.pop()
			if qnames.include?(element1)
				@non_unique_mapper_pos << pos1
				while qnames.include?(element1)
					ind = qnames.index(element1)
					qnames.delete_at(ind)
					pos2 = pos.delete_at(ind)
					@non_unique_mapper_pos << pos2
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
		if x > @list_of_lines.length()
			raise "There are only #{@list_of_lines.length} entries!"
		end
		@current_iteration = x
		self.next()
	end


	# Separates unique mappers from non-unique mappers
	def separate_unique_nonunique(outdir)
		unique_out=File.new(outdir+"_u",'w')
		non_unique_out=File.new(outdir+"_nu",'w')




	end




	private
	def entries_to_s(positions)
		out = ""
		for pos in positions
			  pos = pos - 1
				entry = content_at(pos)
				out = "#{out}#{entry.to_s()}"
		end
		return out
	end



end

