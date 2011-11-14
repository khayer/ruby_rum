require "fasta_parser"

module FastqParser<Parser
  class File
    include Enumerable

    def initialize(filename)
      if filename
        # use the root Ruby File class to open a file
        @filehandler = ::File.open(filename)
        @list_of_positions = []
        pos = @filehandler.pos
        @filehandler.each do |entry|
            if entry.include? "@"
              @list_of_positions << pos
            end
          pos = @filehandler.pos
        end


      @current_iteration = 0
      @filehandler.pos=0
    end

    attr_accessor :list_of_positions, :current_iteration


    def self.open(filename)
      self.new(filename)
    end

    # This method returns the entry matching the current_iteration number
    def next()

      @filehandler.pos = @list_of_positions[@current_iteration]

      if @list_of_positions.length > @current_iteration
          @current_iteration += 1
      end

      make_entry()

    end


    # Now the actual iterator
    def each
        for i in @list_of_positions
          yield self.next()
        end
    end


    ## Helper Method: make_entry; Makes an Entry object to the current file-position
    def make_entry()

      seq_id = @filehandler.readline.chomp
      puts seq_id
      sequence = @filehandler.readline.chomp
      identifier = @filehandler.readline.chomp
      quality = @filehandler.readline.chomp

      Entry.new(seq_id, sequence, identifier, quality)
    end

    # returns x'th entry in the file
    def entry_num(x)
      if x < 1
        raise "Invalid entry number!"
      end
      if x > @list_of_positions.length()
        raise "There are only #{@list_of_positions.length} entries"
      end
      # 1-based
      x -= 1
      @current_iteration = x
      self.next()
    end

    # How many entries are in the file?
    def count()
      @list_of_positions.length
    end

    # Returns first entry
    def first()
      entry_num(1)
    end

    # Returns last entry
    def last()
      entry_num(count())
    end

    def to_fasta


    end

  end
end