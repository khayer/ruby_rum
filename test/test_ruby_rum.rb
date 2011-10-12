require 'test/unit'
require "ruby_rum"
#require_relative '../lib/ruby_rum'

class MyUnitTests < Test::Unit::TestCase

	def setup()
		
		
	end

	def test_call_bowtie()
		out = "e_coli_result"
		para = RubyRum::PreBowtie.new("/Users/hayer/bowtie/reads/e_coli_1000_1.fq", "/Users/hayer/bowtie/reads/e_coli_1000_2.fq", "/Users/hayer/bowtie/indexes/e_coli", "/Users/hayer/bowtie/bowtie", out )
	   	assert_equal(File.exist?(out), true)
	end


end