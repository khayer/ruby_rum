require 'test/unit'
require "ruby_rum"
#require_relative '../lib/ruby_rum'

class TestBowtie2 < Test::Unit::TestCase

	def setup()
		@test_dir = "test/fixtures/"
		@output_file = Bowtie2Parser.open(@test_dir+"zebrafish_result.sam")
		#@output_file2 = Bowtie2Parser.new(@test_dir+"ified")
		filehandler = ::File.new(@test_dir+"bowtie_line")
    @content = Bowtie2Entry.new(filehandler)
	end

	def test_bowtie2_content_initialize()
		assert_equal(@content.seq,"GTAATTTGAGTAATGCCCACCAGTTCCATCACGAT" )
	end

	def test_bowtie2_content_to_s()
		str = @content.to_s()
		assert_equal(str, "r14/1	0	gi|110640213|ref|NC_008253.1|	39899	255	35M	*	0	0	GTAATTTGAGTAATGCCCACCAGTTCCATCACGAT	EDCCCBAAAA@@@@?>===<;;9:99987776554\n" )
	end

	def test_inspect_bowtie2_content()
		str = @content.inspect()
		assert_equal(str,"Bowtie2Entry:r14/1")
	end


	def test_call_bowtie()
		out = @test_dir+"e_coli_result_bowtie2"
		para = BowtieRunner.new("bowtie2", @test_dir+"indexes/e_coli", @test_dir+"reads/e_coli_1000_1.fq", out )
		para.call_bowtie()
   	assert_equal(::File.exist?(out), true)

   	out2 = @test_dir+"e_coli_result2_bowtie2"
   	para2 = BowtieRunner.new("/bowtie/reads/e_coli_100_1.fq", "/bowtie/reads/e_coli_1000_2.fq", "/bowtie/indexes/e_coli", "/bowtie/bowtie", out2 )
   	para.call_bowtie()
   	assert_equal(File.exist?(out2), false)
   	File.delete(out)

   	# This is working, but taking to much time...
   	#out3 = "hg_19_result"
   	#para2 = Bowtie::PreBowtie.new("/bowtie/reads/example2_R1_001.fastq", "/bowtie/reads/example2_R2_001.fastq", "/bowtie/indexes/hg19_genome", "/bowtie/bowtie", out3 )
   	#assert_equal(File.exist?(out3), true)
	end

	def test_bowtie_parser_open()
		#list_lines = @output_file.list_of_lines()
		#assert_equal(list_lines.length, 2183)
	end

	def test_bowtie_parser_next()
		entry = @output_file2.next()
		assert_equal(entry.q_name, "r963/1")
	end

	def test_bowtie_parser_content_at()
		#entry = @output_file2.content_at(3)
		#assert_equal(entry.q_name, "r966/1")
	end

	def test_bowtie_non_unique_to_s()
		#str = @output_file2.non_unique_to_s()
		#assert_equal(str, "r968/1\t16\tgi|110640213|ref|NC_008253.1|\t4833010\t255\t35M\t*\t0\t0\tCTCAGGCAATAAACGTCTTCATTTCATCCATCAGG\t45567778999:9;;<===>?@@@@AAAABCCCDE\nr968/1\t16\tgi|110640213|ref|NC_008253.1|\t4019755\t255\t35M\t*\t0\t0\tCTCAGGCAATAAACGTCTTCATTTCATCCATCAGG\t45567778999:9;;<===>?@@@@AAAABCCCDE\n")
	end



end