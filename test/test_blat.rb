require 'test/unit'
require 'ruby_rum'

class TestBlat < Test::Unit::TestCase

	def setup()
    @test_dir = "test/fixtures/"


	end

  def test_pre_blat_call_blat()
    out_dir = @test_dir+"blat_result2"
    current = BlatRunner.new("~/bin/blat",@test_dir+"chr2.fa",@test_dir+"reads.fa",out_dir)
    current.call_blat()
    assert_equal(current.output, "Loaded 243199373 letters in 1 sequences\nSearched 200 bases in 4 sequences\n")
  end

  def test_parser_new
    parsed = @test_dir+"parsed"
    current = BlatParser.new(@test_dir+"blat_result")
    current.parse_to_file(parsed)
    assert(File.exist?(parsed+"_unique"))
    assert(File.exist?(parsed+"_non_unique"))
  end

  def test_blat_content_score
    filehandler = ::File.new(@test_dir+"blat_line")
    current = BlatEntry.new(filehandler)
    assert_equal(current.score(),30)
  end





end