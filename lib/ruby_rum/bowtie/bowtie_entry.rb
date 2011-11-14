class BowtieEntry<Entry
	# sam-file
	def initialize(filehandler)
		line = filehandler.readline()
		tmp = line.split(" ")
		@q_name = tmp[0]
		@flag = tmp[1]
		@rname = tmp[2]
		@pos = tmp[3]
		@mapq = tmp[4]
		@cigar = tmp[5]
		@rnext = tmp[6]
		@pnext = tmp[7]
		@tlen = tmp[8]
		@seq = tmp[9]
		@qual = tmp[10]
	end
	attr_accessor :q_name, :flag, :rname, :pos, :mapq, :cigar, :rnext, :pnext, :tlen, :seq, :qual
	def to_s
		"#{@q_name}\t#{@flag}\t#{@rname}\t#{@pos}\t#{@mapq}\t#{@cigar}\t#{@rnext}\t#{@pnext}\t#{@tlen}\t#{@seq}\t#{@qual}\n"
	end

end
