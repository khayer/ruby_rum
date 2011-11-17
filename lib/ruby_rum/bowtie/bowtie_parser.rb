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


	# Separates unique mappers from non-unique mappers
	def separate_unique_nonunique(outdir)
		unique_out=File.new(outdir+"_u",'w')
		non_unique_out=File.new(outdir+"_nu",'w')
		@filehandler = @start_pos
    entry1 = make_entry()
		entries = []
		entries_reverse = []

		if entry1.qname.include? "REV"
			entries_reverse<<entry1
		else
			entries<<entry1
		end

		while !@filehandler.eof?
			entry2 = make_entry()
			case
			when entry1.qname == entry2.qname
				entries<<entry2
				entry1=entry2
			when "#{entry1.qname}REV" == entry2.qname
				entries_reverse<<entry2
				entry1=entry2
			else
				compare(entries,entries_reverse)
				entries = []
				entries_reverse = []
				entry1=entry2
			end
		end

	end

	private
	def compare(entries,entries_reverse)
		entry1 = entries.pop()
		unique_mappers = []
		non_unique_mappers = []
		not_mapped = []
		while entry1
			for entry2 in entries_reverse
				# compare if it is on the same chr and if it is in range or overlapped
			end

			entry1 = entries.pop()
		end

		entry1 = entries_reverse.pop()
		while entry1
			entry2 = entries_reverse.pop()

		end





end

