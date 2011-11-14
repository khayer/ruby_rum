
class FastqEntry<Entry
  def initialize(filehandler)
    @seq_id = filehandler.readline.chomp
    @sequence = filehandler.readline.chomp
    @identifier = filehandler.readline.chomp
    @quality = filehandler.readline.chomp
    @q_name = @seq_id
  end

  attr :seq_id, :sequence, :identifier, :quality

  def to_s
    @seq_id + "\n" + @sequence + "\n" + @identifier + "\n" + @quality
  end

end
