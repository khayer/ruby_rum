class Parser

  include Enumerable

  def initialize(filename)
    @filename=filename
    @filehandler=File.new(filename, 'r')
    @entry_counter=0
  end

  attr_accessor :filename, :entry_counter

  def each()
    while !@filehandler.eof()
      @entry_counter += 1
      yield self.next()
    end
  end

  def next()
    self.make_entry()
  end

  def inspect()
    "#{self.class}:#{@filename}"
  end

  def make_entry()
  end

  def parse_to_file()
  end

end





