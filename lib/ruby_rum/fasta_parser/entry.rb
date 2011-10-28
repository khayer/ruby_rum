 class Entry

    def initialize(header,sequence)
      # Header is ">XX|GGGGGGGG|XXX|AAAAAAAAAAA| ..."
      @header = header.chomp
      parse_header()
      # If sequence is an Array, then join the separate entries
      if sequence.kind_of? Array
        # chomp newlines & whitespace, then join with empty string
        sequence = sequence.map{|s| s.strip }.join("")
      end
      @sequence = sequence
    end
    attr :header, :sequence, :gi_num, :accession, :description

    def header=(h)
      @header = h
      parse_header()
    end

    def parse_header()
      tmp = @header.split("|")
      if (tmp[0] == ">gi")
        @gi_num = tmp[1]
        @accession = tmp[3]
        @description = tmp[-1]
      end
    end

    def cut_sequence(number)
        i = 0
        seq = ""
        while i < number
            seq = seq + @sequence[i]
            i += 1
        end
        @sequence = seq
    end

    ## Not needed anymore
    # # returns the GI number
    # def gi_num()

    #   gi_num = String.new
    #   header = []
    #   header = @header.split(//)
    #   i = header.index("|") + 1


    #   while true
    #     unless header[i] == "|"
    #       gi_num << header[i]
    #       #return gi_num
    #     else
    #       break
    #     end
    #     i += 1
    #   end
    #   @gi_num ||= gi_num
    # end
    # def gi_num=(gi)
    #   @gi_num = gi
    # end
    # returns the accession number
    # def accession_num()
    #   accession_num = String.new
    #   header = []
    #   header = @header.split(//)
    #   # Header is         "...|GGGGGGGG         | ... |AAAAAAAAAAA| ..."
    #   i = header.index("|") +  @gi_num.length + 2
    #   while true
    #     unless header[i] == "|"
    #       i += 1
    #     else
    #       break
    #     end
    #   end
    #   i += 1
    #   while true
    #     unless header[i] == "|"
    #       accession_num << header[i]
    #     else
    #       break
    #     end
    #     i += 1
    #   end
    #   @accession_num ||= accession_num
    # end

    ## Handled in initialize step
    # # Returns the sequence of the entry without "\n"
    # def sequence()
    #   seq = @sequence
    #   seq.delete("\n")
    # end

    # # The entry is printed as seen in the original file
    # def printEntry()
    #   puts @header
    #   puts @sequence
    # end

    # Ruby classes use a "to_s()" method for defining the pretty printout
    # Also do not use puts() in class methods, that is only for scripts. Instead return
    # the String directly to the script so it can decide what to do with it.
    def to_s
      @header + "\n" + @sequence
    end

    # Ruby classes also use "inspect()" to return an nice looking value in the irb shell
    def inspect()
      "#{self.class}:#{@header}"
    end

  end