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

  def test_blat_content_score
    current = BlatParser::BlatContent.new("33  3 0 0 0 0 3 4 + HWI-ST431:108:D03H3ACXX:3:1101:1578:1914  50  9 42  chr2  243199373 96344315  96344352  4 4,7,17,5, 9,13,20,37, 96344315,96344320,96344329,96344347,  cttt,tctcttt,cttccttctttcttccc,tcctc, cttt,tctcttt,cttccttctttcttccc,tcctc,")
    assert_equal(current.score(),30)
  end





end