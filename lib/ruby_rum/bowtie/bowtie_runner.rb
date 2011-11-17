class BowtieRunner<Runner
	# Parameters
	def initialize(bowtiedir, genom, read1 , read2 ,  outdir)
		@read1 = read1 #FASTQ
		@read2 = read2 #FASTQ
		@genom = genom
		@bowtiedir = bowtiedir
		@outdir = outdir
		# add path for bowtie exutables
	end
	attr :read1, :read2, :chunk	, :genom, :outdir
	# Example: /ifs/apps/bowtie/bowtie-0.12.7/bowtie -a --best --strata /ifs/apps/RUM/current/indexes/hg19_genome /ifs/hts_up/example_dataset/example_R1_001.fastq,/ifs/hts_up/example_dataset/example_R2_001.fastq -v 3 --suppress
	def call_bowtie()

		# Bowtie exutables in File
		# Example: /ifs/apps/bowtie/bowtie-0.12.7/bowtie -a --best --strata  --pairtries 1000 --chunkmbs 1024 /ifs/apps/RUM/current/indexes/hg19_genome /ifs/hts_up/example_dataset/example_R1_001.fastq,/ifs/hts_up/example_dataset/example_R2_001.fastq -v 3 --suppress 6,7,8 -p 1 --quiet -S  test2
		cmd = "#{@bowtiedir} -a --best --strata --pairtries 1000 --chunkmbs 1024 -v 3  #{@genom} #{@read1},#{@read2} --suppress 6,7,8 -p 1 --quiet -S #{@outdir}"
		a = Thread.new {z=system(cmd)}
		b = Thread.new {
			while a.alive?
				sleep 1
			end
			if a.status == nil
				raise("Bowtie did not perform the way it was suppose to")
			end
		}
		a.join
		b.join


	end
end
