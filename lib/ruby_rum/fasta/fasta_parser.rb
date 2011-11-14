
class FastaParser<Parser
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
    else
      @filehandler = nil
      @list_of_positions = []
    end
    @current_iteration = 0
  end
  attr_accessor :list_of_positions, :current_iteration

  # opens a FASTA file by passing the path as a String and saves the details
  def self.open(filename)
    self.new(filename)
  end
  # This method returns the entry matching the current_iteration number
  def next()
    @filehandler.seek(@list_of_positions[@current_iteration], IO::SEEK_SET)
    if @list_of_positions.length > @current_iteration
        @current_iteration += 1
    end
    make_entry()
  end

  ## Helper Method: make_entry; Makes an Entry object to the current file-position
  def make_entry()
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

    FastaEntry.new(header,sequence)
  end
  public
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
end
