module BlatParser
  class PreBlat
    #runtime
    def initialize(blatdir, database, query, outputdir, options="-minScore=20 -minIdentity=93 -stepSize=5")
      @blatdir = blatdir
      @database = database
      @query = query
      @outputdir = outputdir
      @options = options
    end

    def call_blat()
      cmd = "#{@blatdir}  #{@database} #{@query} #{@outputdir} #{@options} -out=pslx"
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
      puts File.exist?(@outputdir)

    end

  end
end