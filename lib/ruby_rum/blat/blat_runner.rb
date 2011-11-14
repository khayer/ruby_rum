class BlatRunner<Runner
  #runtime
  def initialize(blatdir, database, query, outputdir, options="-minScore=20 -minIdentity=93 -stepSize=5")
    @blatdir = blatdir
    @database = database
    @query = query
    @outputdir = outputdir
    @options = options
    @output = ""
  end
  attr_accessor :output
  def call_blat()
    cmd = "#{@blatdir}  #{@database} #{@query} #{@outputdir} #{@options} -out=pslx >#{@outputdir}result.txt"
    a = Thread.new{system(cmd)}
    b = Thread.new{
      while a.alive?
        sleep 1
      end
      if a.status == nil
        raise("Blat died...")
      end
    }
    a.join
    b.join
    z = ::File.new(@outputdir+"result.txt")
    z.each do |line|
      line = line
      @output += line
    end
    File.delete(z)
    File.exist?(@outputdir)
  end
end
