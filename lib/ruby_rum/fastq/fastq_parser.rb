class FastqParser<Parser

  include Enumerable

  def initialize(filename)
    super(filename)

    line=@filehandler.readline.chomp()
    splitted_line = line.split("")
    if splitted_line[0] != "@"
      raise "Expected was FASTQ!"
    else
      @filehandler.pos=0
    end
  end

  attr_accessor :list_of_positions, :current_iteration

  def make_entry()
    FastqEntry.new(@filehandler)
  end

  def parse_to_file()
    fail "Not implemented!"
  end

  def parse_to_fasta(outdir)
    out = ::File.new(outdir,'w')
    each do |entry|
      header = ">"+entry.seq_id.delete("@")
      sequence = entry.sequence()
      entry_fa = FastaEntry.new(header, sequence)
      out.write(entry_fa.to_s()+"\n")

    end
    out.close

  end

end
