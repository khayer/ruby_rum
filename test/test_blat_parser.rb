require 'test/unit'
require 'ruby_rum'

class MyUnitTests < Test::Unit::TestCase

	def setup()
    @test_dir = "test/fixtures/"


	end

  def test_pre_blat_call_blat()
    out_dir = @test_dir+"blat_result2"
    current = BlatParser::PreBlat.new("~/bin/blat",@test_dir+"chr2.fa",@test_dir+"reads.fa",out_dir)
    current.call_blat()
    assert_equal(current.output, "Loaded 243199373 letters in 1 sequences\nSearched 200 bases in 4 sequences\n")
  end

  def test_parser_new
    parsed = @test_dir+"parsed"
    BlatParser::Parser.new(@test_dir+"blat_result", parsed)
    assert(File.exist?(parsed+"_unique"))
    assert(File.exist?(parsed+"_non_unique"))
  end





end