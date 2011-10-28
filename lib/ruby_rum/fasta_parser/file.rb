module FastaParser
  class File
    include Enumerable

    def initialize(filename=nil)
      if filename
        # use the root Ruby File class to open a file
        @filehandler = ::File.open(filename)
        @list_of_positions = []
        pos = @filehandler.pos
        @filehandler.each do |entry|
            if entry.include? ">"
              @list_of_positions << pos
            end
          pos = @filehandler.pos
        end

        # extra instance variable not needed
        # @list_of_positions = list_of_positions

      else
        # needed to be able to access the file again
        @filehandler = nil
        # positions hold the pointer positions of the header
        @list_of_positions = []
        # this is importan for iteration()
        # this instance var not needed and should not be used
        # @entries = []
      end
      @current_iteration = 0
    end

    attr_accessor :list_of_positions, :current_iteration
    # def list_of_positions()
    #   @list_of_positions
    # end

    # def current_iteration()
    #   @current_iteration
    # end
    ## Deleted this method, since it is not a good thing to do for iteration
    ## See changeset
    # def add_entry(entry)
    #   @entries << entry
    # end


    # opens a FASTA file by passing the path as a String and saves the details
    def self.open(filename)
      self.new(filename)
    end

    # This method returns the entry matching the current_iteration number
    def next()
      @filehandler.seek(@list_of_positions[@current_iteration], IO::SEEK_SET)
      # alternate way to do the same thing as above
      # @filehandler.pos = @list_of_positions[@current_iteration]

      if @list_of_positions.length > @current_iteration
          @current_iteration += 1
      # else
      #   # Not a good thing to do within classes. For instance, what if the
      #   # user is using this to redirect STOUT to a file of processed FASTA entries?
      #   # Now they will have this line in a FASTA file and cause errors for any program
      #   # that uses the output.
      #    puts "No more entries left after this one!"
      end

      # no need for intermediate object
      # entry = make_entry(@filehandler)
      # return entry
      make_entry()
    end


    # Now the actual iterator
    def each &block
      while(!@filehandler.eof?)
        yield self.next()
      end
    end


    ## Helper Method: make_entry; Makes an Entry object to the current file-position
    def make_entry()
    ## already have access to a the instance var @filehandler, no need to pass it in
    # def make_entry(f)
      # remove the trailing newline
      header = @filehandler.readline.chomp
      sequence = ""
      # f.each do |line|
      @filehandler.each do |line|
        unless line.include? ">"
          sequence += line.chomp
        else
          break
        end
      end
      # no need to create the object, just return the new annonymous instance
      # entry = Entry.new(header,sequence)
      # return entry
      Entry.new(header,sequence)
    end

    ### --------- extra credit ----------- ###

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
      # we needed to handle the setting of current_iteration
      # Also next() takes care of setting the position, seeking and calling make_entry
      # Programming principle called "Don't Repeat Yourself" (DRY), leads to less bugs.
      # @filehandler.seek(@list_of_positions[x], IO::SEEK_SET)
      # make_entry()
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

  end
end