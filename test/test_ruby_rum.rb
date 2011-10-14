require 'test/unit'
require "ruby_rum"
#require_relative '../lib/ruby_rum'

class MyUnitTests < Test::Unit::TestCase

	def setup()
		@output_file = RubyRum::BowtieParser.new("e_coli_result")
		@output_file2 = RubyRum::BowtieParser.new("e_coli_result_modified")
		@content = RubyRum::BowtieContent.new("r14/1	0	gi|110640213|ref|NC_008253.1|	39899	255	35M	*	0	0	GTAATTTGAGTAATGCCCACCAGTTCCATCACGAT	EDCCCBAAAA@@@@?>===<;;9:99987776554	XA:i:0	MD:Z:35	NM:i:0")
	end

	def test_bowtie_content_initialize()
		assert_equal(@content.seq,"GTAATTTGAGTAATGCCCACCAGTTCCATCACGAT" )
	end

	def test_bowtie_content_to_s()
		str = @content.to_s()
		assert_equal(str, "r14/1	0	gi|110640213|ref|NC_008253.1|	39899	255	35M	*	0	0	GTAATTTGAGTAATGCCCACCAGTTCCATCACGAT	EDCCCBAAAA@@@@?>===<;;9:99987776554\n" )
	end

	def test_inspect_bowtie_content()
		str = @content.inspect()
		assert_equal(str,"RubyRum::BowtieContent:r14/1")
	end


	def test_call_bowtie()
		out = "e_coli_result"
		para = RubyRum::PreBowtie.new("/bowtie/bowtie", "/bowtie/indexes/e_coli", "/bowtie/reads/e_coli_1000_1.fq", "/bowtie/reads/e_coli_1000_2.fq", out )
   	assert_equal(File.exist?(out), true)
   	out2 = "e_coli_result2"
   	para2 = RubyRum::PreBowtie.new("/bowtie/reads/e_coli_100_1.fq", "/bowtie/reads/e_coli_1000_2.fq", "/bowtie/indexes/e_coli", "/bowtie/bowtie", out2 )
   	assert_equal(File.exist?(out2), false)

   	# This is working, but taking to much time...
   	#out3 = "hg_19_result"
   	#para2 = RubyRum::PreBowtie.new("/bowtie/reads/example2_R1_001.fastq", "/bowtie/reads/example2_R2_001.fastq", "/bowtie/indexes/hg19_genome", "/bowtie/bowtie", out3 )
   	#assert_equal(File.exist?(out3), true)
	end

	def test_bowtie_parser_open()
		list_lines = @output_file.list_of_lines()
		assert_equal(list_lines.length, 2184)
	end

	def test_bowtie_parser_next()
		entry = @output_file2.next()
		assert_equal(entry.qname, "r963/1")
	end

	def test_bowtie_parser_content_at()
		entry = @output_file2.content_at(3)
		assert_equal(entry.qname, "r966/1")
	end

	def test_bowtie_non_unique_to_s()
		str = @output_file2.non_unique_to_s()
		assert_equal(str, "r968/1\t16\tgi|110640213|ref|NC_008253.1|\t4833010\t255\t35M\t*\t0\t0\tCTCAGGCAATAAACGTCTTCATTTCATCCATCAGG\t45567778999:9;;<===>?@@@@AAAABCCCDE\nr968/1\t16\tgi|110640213|ref|NC_008253.1|\t4019755\t255\t35M\t*\t0\t0\tCTCAGGCAATAAACGTCTTCATTTCATCCATCAGG\t45567778999:9;;<===>?@@@@AAAABCCCDE\n")
	end



end