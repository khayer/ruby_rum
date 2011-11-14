require "ruby_rum/fasta/fasta_entry"
require "ruby_rum/fasta/fasta_parser"

module Fasta

  # combines paired reads to one in a fasta file
  def combine(filename1, filename2, outdir)
    f1 = ::File.new(filename1, 'r')
    f2 = ::File.new(filename2, 'r')
    out = ::File.new(outdir,'w')
    i = 0
    str_n = ""
    # generating string with 50 N's
    while i<50
      str_n = "#{str_n}N"
      i += 1
    end
    seq1 = ""
    seq2 = ""
    line1 = f1.readline().chomp
    line2 = f2.readline().chomp
    tmp1 = line1.split(" ")
    tmp2 = line2.split(" ")
    header = "#{tmp1[0]}::#{tmp2[0]}"
    while !f2.eof?()
      line2 = f2.readline().chomp
      line1 = f1.readline().chomp
      unless line1.include?('>')
        seq1 = seq1 + "#{line1}"
        seq2 = seq2 + "#{line2}"
      else
        seq = seq1 + str_n + seq2
        seq1 = ""
        seq2 = ""
        str = "#{header}\n#{seq}"
        out.write(str+"\n")
        tmp1 = line1.split(" ")
        tmp2 = line2.split(" ")
        header = "#{tmp1[0]}::#{tmp2[0]}"
      end
    end
    out.write(header+"\n"+seq1+str_n+seq2+"\n")
  end
  # combines paired reads to one in a fasta file
  def combine_seriell(filename1, filename2, outdir)
    f1 = ::File.new(filename1, 'r')
    f2 = ::File.new(filename2, 'r')
    out = ::File.new(outdir,'w')
    i = 0
    str_n = ""
    seq1 = ""
    seq2 = ""
    line1 = f1.readline().chomp
    line2 = f2.readline().chomp
    tmp1 = line1.split(" ")
    tmp2 = line2.split(" ")
    header1 = "#{tmp1[0]}"
    header2 = "#{tmp2[0]}"
    while !f2.eof?()
      line2 = f2.readline().chomp
      line1 = f1.readline().chomp
      unless line1.include?('>')
        seq1 = seq1 + "#{line1}"
        seq2 = seq2 + "#{line2}"
      else
        seq = seq1 + str_n + seq2
        seq1 = ""
        seq2 = ""
        str = "#{header1}\n#{seq1}\n#{header2}@\n#{seq2}"
        out.write(str+"\n")
        tmp1 = line1.split(" ")
        tmp2 = line2.split(" ")
        header1 = "#{tmp1[0]}"
        header2 = "#{tmp2[0]}"
      end
    end
    out.write(header1+"\n"+seq1+"\n"+header2+"@\n"+seq2+"\n")
  end
end
