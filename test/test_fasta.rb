require 'test/unit'
require 'ruby_rum'
include Fasta

# require_relative '../lib/fasta_parser'

# main class names should be the CamelCase equivalent of the snake_case file name
# unless there is a very good reason to be different.
class TestFasta < Test::Unit::TestCase

  def setup()
    @fasta_file = FastaParser.open(File.join("test", "fixtures", "sequences.fasta"))
  end

  def test_open()
    assert(@fasta_file.instance_of?(FastaParser), "Not a FastaParser instance")
  end

  def test_each()
    # read in header lines, split by newlines
    headers = File.read("test/fixtures/headers.txt").split(/\n/)

    # Now iterate through the fasta file, testing the order of the headers
    @fasta_file.each_with_index  do |entry,i|
      assert(entry.kind_of? FastaEntry)
      assert_equal(headers[i], entry.header)
    end
  end

  def test_combine_fasta_parse_to_file()

    test_dir = "test/fixtures/"
    out = "#{test_dir}example_combined.fa"
    combine(test_dir+"R1_example.fq", test_dir+"R2_example.fq", out)
    assert(File.exist?(out))
    File.delete(out)

   #File.open(out)

   #File.open(out)
   #assert_equal(@current_file.list_of_positions.length, 14703)
   #assert_equal(@current_file.list_of_positions[0],0)
  end


  # def test_each()

  #   entry1 = @current_file.next()
  #     entry2 = @current_file.next()
  #     entry3 = @current_file.next()
  #     entry4 = @current_file.next()
  #     @current_file.add_entry(entry1)
  #     @current_file.add_entry(entry2)
  #     @current_file.add_entry(entry3)
  #     @current_file.add_entry(entry4)

  #     gi_nums = @current_file.entries.map{|entry| entry.gi_num}
  #     assert_equal(gi_nums,["73945336", "73945338", "73945340", "73945342"])

  # end

  def test_next()
    @fasta_file.first()
    # gets the second entry
    entry = @fasta_file.next()
    assert_equal(">gi|350529365|ref|NM_001244990.1| Homo sapiens protein phosphatase 1, regulatory subunit 12A (PPP1R12A), transcript variant 4, mRNA",entry.header)
    assert_equal(2,@fasta_file.current_iteration)
  end

  def test_gi_num()
    entry = @fasta_file.first()
    assert_equal("350529369", entry.gi_num)
  end

  def test_accession_num()
    entry = @fasta_file.first()
    assert_equal("NM_001244992.1", entry.accession)
  end


  def test_sequence
    expected_sequence = "ACCCGGCGGCAGGAGAGGGGATGAAGATGGCGGACGCGAAGCAGAAGCGGAACGAGCAGCTGAAACGCTGGATCGGCTCCGAGACGGACCTCGAGCCTCCGGTGGTGAAGCGCCAGAAGACCAAGGTGAAGTTCGACGATGGCGCCGTCTTCCTGGCTGCTTGCTCCAATTGATGACAATGTTGATATGGTGAAGTTTCTGGTAGAAAATGGAGCAAATATTAATCAACCTGATAATGAAGGCTGGATACCACTACATGCAGCAGCTTCCTGTGGATATCTTGATATTGCAGAGTTTTTGATTGGTCAAGGAGCACATGTAGGGGCTGTCAACAGTGAAGGAGATACACCTTTAGATATTGCGGAGGAGGAGGCAATGGAAGAGCTACTTCAAAA"
    entry = @fasta_file.first()
    assert_equal(expected_sequence, entry.sequence)
  end

  def test_entry_num
    fifth_entry = @fasta_file.entry_num(5)
    assert_equal("349501060",fifth_entry.gi_num())
  end

  def test_bad_index
    assert_raise RuntimeError do
      fifth_entry = @fasta_file.entry_num(14704)
    end
    assert_raise RuntimeError do
      fifth_entry = @fasta_file.entry_num(-4)
    end
  end
  def test_count
      number_of_elements = @fasta_file.count()
      assert_equal(number_of_elements,10)
  end

  # since I had my own test file, I changed below.
  def test_first
      first_entry = @fasta_file.first()
      assert_equal("NM_001244992.1",first_entry.accession())
  end

  def test_last
      last_entry = @fasta_file.last()
      assert_equal("NM_001114122.2",last_entry.accession())
  end

  def test_cut_seq()
    @fasta1 = FastaParser.open("test/fixtures/100ReadsOf100.fa")
    z1 = ::File.open("test/fixtures/100ReadsOf50.fa", 'w')

    @fasta2 = FastaParser.open("test/fixtures/200ReadsOf100.fa")
    z2 = ::File.open("test/fixtures/200ReadsOf50.fa", 'w')

    for i in @fasta1.list_of_positions
      entry = @fasta1.next()
      entry.cut_sequence(50)
      z1.write(entry.to_s() + "\n")
    end

    for i in @fasta2.list_of_positions
      entry = @fasta2.next()
      entry.cut_sequence(50)
      z2.write(entry.to_s() + "\n")
    end

  end

end