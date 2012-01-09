class Bowtie2Parser<Parser
	# The output file is a SAM file so we
	include Enumerable
	def initialize(filename = nil)
		super(filename)
		avoid_header()
		@start_pos = @filehandler.pos
		@unique_counter=0
		@non_unique_counter=0
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
				seperate_same_name(entries,entries_reverse, unique_out, non_unique_out)
				entries = []
				entries_reverse = []
				entry1=entry2
			end
		end
		seperate_same_name(entries,entries_reverse, unique_out, non_unique_out)
	end

	private
	def seperate_same_name(entries,entries_reverse,unique_out,non_unique_out)


		paired=[]
		unpaired=[]

		entry1 = entries.pop()
		if entry1.rname == "*"
			not_mapped<<entry1
		else

			while entry1
				unpaired<<entry1
				entries_reverse.each do |entry|
					# compare if it is on the same chr and if it is in range or overlapped
					if entry1.rname == entry.rname && is_in_range?(entry1.pos,entry2.pos)
						unpaired.delete(entry1)
						paired<<entry1
						paired<<entries_reverse.pop(entry)
					end
				end
				entry1 = entries.pop()
			end
		end

		entry2 = entries.pop()
		if entry2.rname == "*"
			not_mapped<<entry1
		else
			while entry2
				unpaired<<entry1
			end
		end

		case
		when !paired.empty?()
			if paired.length()>2
				@non_unique_counter+=1
				each.paired do |entry|
					entry_fa = entry.to_fasta()
					non_unique_out.write(entr_fa.to_s()+"\n")
				end
			else
				@unique_counter+=1
				each.paired do |entry|
					entry_fa = entry.to_fasta()
					unique_out.write(entr_fa.to_s()+"\n")
				end
			end

		when !unpaired.empty?
			if unpaired.length()>1 && paired.isempty?()
				puts "BUUUUH"
			end
		end
	end
end

