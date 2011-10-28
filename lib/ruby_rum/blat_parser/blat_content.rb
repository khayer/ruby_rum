module BlatParser
  class BlatContent
    # .pslx files expected!
    def initialize(line)
      tmp = line.split(" ")
      @matches = tmp[0]
      @mis_matches = tmp[1]
      @rep_matches = tmp[2]
      @n_count = tmp[3]
      @q_num_insert = tmp[4]
      @q_base_insert = tmp[5]
      @t_num_insert = tmp[6]
      @t_base_insert = tmp[7]
      @strand = tmp[8]
      @q_name = tmp[9]
      @q_size = tmp[10]
      @q_start = tmp[11]
      @q_end = tmp[12]
      @t_name = tmp[13]
      @t_size = tmp[14]
      @t_start = tmp[15]
      @t_end = tmp[16]
      @block_count = tmp[17]
      @block_sizes = tmp[18]
      @q_starts = tmp[19]
      @t_starts = tmp[20]
      @seq = tmp[21]
    end

    attr_accessor :q_name, :t_name, :t_start, :t_end

    def to_s()
      str = @matches+"\t"+@mis_matches+"\t"+@rep_matches+"\t"+@n_count+"\t"+@q_num_insert+"\t"+@q_base_insert+"\t"+@t_num_insert+"\t"+@t_base_insert+"\t"+@strand+"\t"+@q_name+"\t"+@q_size+"\t"+@q_start+"\t"+@q_end+"\t"+@t_name+"\t"+@t_size+"/t"+@t_start+"/t"+@t_end+"/t"+@block_count+"/t"+@block_sizes+"/t"+@q_starts+"/t"+@t_starts+"/t"+@seq
    end
  end
end

# source: http://genome.ucsc.edu/FAQ/FAQformat.html#format2 , 10/24/2011 10:25 AM
# matches - Number of bases that match that aren't repeats
# misMatches - Number of bases that don't match
# repMatches - Number of bases that match but are part of repeats
# nCount - Number of 'N' bases
# qNumInsert - Number of inserts in query
# qBaseInsert - Number of bases inserted in query
# tNumInsert - Number of inserts in target
# tBaseInsert - Number of bases inserted in target
# strand - '+' or '-' for query strand. For translated alignments, second '+'or '-' is for genomic strand
# qName - Query sequence name
# qSize - Query sequence size
# qStart - Alignment start position in query
# qEnd - Alignment end position in query
# tName - Target sequence name
# tSize - Target sequence size
# tStart - Alignment start position in target
# tEnd - Alignment end position in target
# blockCount - Number of blocks in the alignment (a block contains no gaps)
# blockSizes - Comma-separated list of sizes of each block
# qStarts - Comma-separated list of starting positions of each block in query
# tStarts - Comma-separated list of starting positions of each block in target#