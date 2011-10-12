module RubyRum
	class BowtieContent

		def initialize(line) 
			tmp = line.split(" ")
			@qname = tmp[0]
			@flag = tmp[1]
			@rname = tmp[2]
			@pos = tmp[3]
			@mapq = tmp[4]
			@cigar = tmp[5]
			@rnext = tmp[6]
			@pnexr = tmp[7]
			@tlen = tmp[8]
			@seq = tmp[9]
			@qual = tmp[10] 
		end

		attr_accessor :qname, :flag, :rname, :pos, :mapq, :cigar, :rnext, :pnext, :tlen, :seq, :qual

	end
end