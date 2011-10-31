module BlatParser
  class Parser
    include Enumerable

    def initialize(filename , outdir, maxpairdist = 500000)

        @filehandler = ::File.open(filename)
        @outdir = outdir

        #range in which a sequence is still considered unique
        @maxpairdist = maxpairdist

        @counter_unique = 0
        @counter_non_unique = 0

        line = avoid_header()
        parse_to_file(line)
    end

    attr_accessor :list_of_lines, :current_iteration, :list_of_header, :unique_mapper_pos, :non_unique_mapper_pos

    def each
      yield self.next
    end

    def next()
      make_content(@filehandler.readline())
    end

    def inspect()
      "#{self.class}:#{@filename}"
    end



    def avoid_header()
      line = @filehandler.readline()
      aline = line.split()

      # getting rid off header
      while !is_a_number?(aline[0])
        line = @filehandler.readline()
        aline = line.split()
      end
      line
    end

    def make_content(line)
      content = BlatParser::BlatContent.new(line)
    end

    # Parses into unique and non-unique mappers
    # unique means, that even if a read got mapped
    # more than once, it can be still unique if:
    # - it is on the same chromosome AND
    # - it is in the same general area (@maxpairdist)

    def parse_to_file(line)

      z_unique = File.new(@outdir+"_unique", 'w')
      z_non_unique = File.new(@outdir+"_non_unique", 'w')
      entries = []

      while !@filehandler.eof?
        entry1 = make_content(line)
        line = @filehandler.readline()
        entry2 = make_content(line)
        if entry1.q_name == entry2.q_name
          # What if on same chromosome?
          # calling helper procedure
          entries << entry1
          marker2 = true
          while entry1.q_name == entry2.q_name

            # same chrosome?
            if entry1.t_name == entry2.t_name

              entries << entry2

              if @filehandler.eof?
                marker = false
                break
              else
                line = @filehandler.readline()
                entry2 = make_content(line)
                marker = true
              end

            else
              marker2 = false

              @counter_non_unique += 1

              out = "#{entry1.to_s()}"
              z_non_unique.write(out+"\n")

              while entry1.q_name == entry2.q_name

                out = "#{entry2.to_s()}"
                z_non_unique.write(out+"\n")

                if @filehandler.eof?
                  marker = false
                  break
                else
                  line = @filehandler.readline()
                  entry2 = make_content(line)
                  marker = 1
                end
              end

            end


            if marker2
              is_in_range?(entries, z_unique, z_non_unique)
            end
          end

        else
          @counter_unique += 1
          out = "#{entry1.to_s()}"
          z_unique.write(out+"\n")
          marker = false
        end
      end

      if marker
        @counter_unique += 1
        out = "#{entry2.to_s()}"
        z_unique.write(out+"\n")
      end

      puts "Unique: #{@counter_unique}    Non_unique: #{@counter_non_unique}"
      z_non_unique.close
      z_unique.close
    end

    private


    # only mappers in a certain range are seen as unique mappers
    def is_in_range?(entries, z_unique, z_non_unique)
      smallest = 2**(50)
      biggest = 0

      entries.each do |entry|
        start = entry.t_start.to_i
        ende = entry.t_end.to_i
        if  start > biggest
          biggest = start
        end
        if ende < smallest
          smallest = ende
        end
      end

      diff = biggest - smallest

      if diff < @maxpairdist
        # unique mapper
        @counter_unique += 1
        write_to_file(entries, z_unique)
      else
        # non-unique mapper
        @counter_non_unique += 1
        write_to_file(entries, z_non_unique)
      end

    end

    def write_to_file(entries, filehandler)
      entries.each do |entry|
        out = "#{entry.to_s()}"
        filehandler.write(out+"\n")
      end
    end



    # a little helper
    def is_a_number?(s)
      s.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
    end

  end

end