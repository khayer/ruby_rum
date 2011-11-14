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



    # Ruby classes use a "to_s()" method for defining the pretty printout
    # Also do not use puts() in class methods, that is only for scripts. Instead return
    # the String directly to the script so it can decide what to do with it.
    def to_s()
      @header + "\n" + @sequence
    end

    # Ruby classes also use "inspect()" to return an nice looking value in the irb shell
    def inspect()
      "#{self.class}:#{@header}"
    end

  end