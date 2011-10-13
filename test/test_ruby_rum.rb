require 'test/unit'
require "ruby_rum"
#require_relative '../lib/ruby_rum'

class MyUnitTests < Test::Unit::TestCase

	def setup()
		@output_file = RubyRum::BowtieParser.new("e_coli_result")	
	end

	def test_call_bowtie()
		out = "e_coli_result"
		para = RubyRum::PreBowtie.new("/bowtie/bowtie", "/bowtie/indexes/e_coli", "/bowtie/reads/e_coli_1000_1.fq", "/bowtie/reads/e_coli_1000_2.fq", out )
	   	assert_equal(File.exist?(out), true)
	   	para2 = RubyRum::PreBowtie.new("/bowtie/reads/e_coli_100_1.fq", "/bowtie/reads/e_coli_1000_2.fq", "/bowtie/indexes/e_coli", "/bowtie/bowtie", out )
	   	out2 = "e_coli_result2"
	   	assert_equal(File.exist?(out2), false)
	end

	def test_bowtie_parser_open()

		list_lines = @output_file.list_of_lines()
		assert_equal(list_lines.length, 2186)

	end


end