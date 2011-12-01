require "ruby_rum/fastq/fastq_parser"
require "ruby_rum/fastq/fastq_entry"

module Fastq
  def combine()
    STDERR.puts "Combining of Fastq is not supported!"
  end

  def combine_seriell(filename1, filename2, outdir)
    f1 = ::File.new(filename1, 'r')
    f2 = ::File.new(filename2, 'r')
    out = ::File.new(outdir,'w')
    i = 0
    r1 = ""
    r2 = ""
    while !f2.eof?()
      while i < 4
        r1 += f1.readline()
        r2 += f2.readline()
        i += 1
      end
      i = 0
      str = r1+r2
      out.write(str)
      r1 = ""
      r2 = ""
    end
  end

end


