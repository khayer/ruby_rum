require 'test/unit'
require "ruby_rum"

class TestFastq < Test::Unit::TestCase

  def setup()
    @test_dir = "test/fixtures/"
    @fastq_file = FastqParser.new(@test_dir+"r1_example.fq")
  end

  def test_open()
    assert(@fastq_file.instance_of?(FastqParser), "Not a FastqParser instance")
  end

  def test_each()
    seq_ids = File.read("test/fixtures/seq_ids.txt").split(/\n/)

    @fastq_file.each_with_index  do |entry,i|
      assert(entry.kind_of?(FastqEntry))
      assert_equal(seq_ids[i], entry.seq_id)
    end
  end

  def test_parse_to_fasta()
    @fastq_file.parse_to_fasta(@test_dir+"r1_example.fa")
  end

end