require 'test/unit'
require "ruby_rum/fastq_parser"


# main class names should be the CamelCase equivalent of the snake_case file name
# unless there is a very good reason to be different.
class TestFastqParser < Test::Unit::TestCase

  def setup()
    @fastq_file = FastqParser::FastqFile.open(File.join("test", "fixtures", "r1_example.fq"))
  end

  def test_open()
    assert(@fastq_file.instance_of?(FastqParser::FastqFile), "Not a FastqParser::File instance")
  end

  def test_each()
    # read in header lines, split by newlines
    seq_ids = File.read("test/fixtures/seq_ids.txt").split(/\n/)
     @fastq_file = FastqParser::FastqFile.open(File.join("test", "fixtures", "r1_example.fq"))

    # Now iterate through the fasta file, testing the order of the headers
    @fastq_file.each_with_index  do |entry,i|
      puts i
      assert(entry.kind_of? FastqParser::FastqEntry)
      assert_equal(seq_ids[i], entry.seq_id)
    end
  end



  #def test_next()
  #  @fasta_file.first()
  #  # gets the second entry
  #  entry = @fasta_file.next()
  #  assert_equal(">gi|350529365|ref|NM_001244990.1| Homo sapiens protein phosphatase 1, regulatory subunit 12A (PPP1R12A), transcript variant 4, mRNA",entry.header)
  #  assert_equal(2,@fasta_file.current_iteration)
  #end
#
  #def test_gi_num()
  #  entry = @fasta_file.first()
  #  assert_equal("350529369", entry.gi_num)
  #end
#
  #def test_accession_num()
  #  entry = @fasta_file.first()
  #  assert_equal("NM_001244992.1", entry.accession)
  #end
#
#
  #def test_sequence
  #  expected_sequence = "ACCCGGCGGCAGGAGAGGGGATGAAGATGGCGGACGCGAAGCAGAAGCGGAACGAGCAGCTGAAACGCTGGATCGGCTCCGAGACGGACCTCGAGCCTCCGGTGGTGAAGCGCCAGAAGACCAAGGTGAAGTTCGACGATGGCGCCGTCTTCCTGGCTGCTTGCTCCAATTGATGACAATGTTGATATGGTGAAGTTTCTGGTAGAAAATGGAGCAAATATTAATCAACCTGATAATGAAGGCTGGATACCACTACATGCAGCAGCTTCCTGTGGATATCTTGATATTGCAGAGTTTTTGATTGGTCAAGGAGCACATGTAGGGGCTGTCAACAGTGAAGGAGATACACCTTTAGATATTGCGGAGGAGGAGGCAATGGAAGAGCTACTTCAAAA"
  #  entry = @fasta_file.first()
  #  assert_equal(expected_sequence, entry.sequence)
  #end
#
  #def test_entry_num
  #  fifth_entry = @fasta_file.entry_num(5)
  #  assert_equal("349501060",fifth_entry.gi_num())
  #end
#
  #def test_bad_index
  #  assert_raise RuntimeError do
  #    fifth_entry = @fasta_file.entry_num(14704)
  #  end
  #  assert_raise RuntimeError do
  #    fifth_entry = @fasta_file.entry_num(-4)
  #  end
  #end
  #def test_count
  #    number_of_elements = @fasta_file.count()
  #    assert_equal(number_of_elements,10)
  #end
#
  ## since I had my own test file, I changed below.
  #def test_first
  #    first_entry = @fasta_file.first()
  #    assert_equal("NM_001244992.1",first_entry.accession())
  #end
#
  #def test_last
  #    last_entry = @fasta_file.last()
  #    assert_equal("NM_001114122.2",last_entry.accession())
  #end
#
  #def test_cut_seq()
  #  @fasta1 = FastaParser::File.open("test/fixtures/100ReadsOf100.fa")
  #  z1 = ::File.open("test/fixtures/100ReadsOf50.fa", 'w')
#
  #  @fasta2 = FastaParser::File.open("test/fixtures/200ReadsOf100.fa")
  #  z2 = ::File.open("test/fixtures/200ReadsOf50.fa", 'w')
#
  #  for i in @fasta1.list_of_positions
  #    entry = @fasta1.next()
  #    entry.cut_sequence(50)
  #    z1.write(entry.to_s() + "\n")
  #  end
#
  #  for i in @fasta2.list_of_positions
  #    entry = @fasta2.next()
  #    entry.cut_sequence(50)
  #    z2.write(entry.to_s() + "\n")
  #  end



end