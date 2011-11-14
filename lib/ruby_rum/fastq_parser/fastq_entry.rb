module FastqParser
 class FastqEntry

    def initialize(seq_id, sequence, identifier, quality)

      @seq_id = seq_id
      @sequence = sequence
      @identifier = identifier
      @quality = quality

    end

    attr :seq_id, :sequence, :identifier, :quality

    def to_s
      @seq_id + "\n" + @sequence + "\n" + @identifier + "\n" + @quality
    end

    # Ruby classes also use "inspect()" to return an nice looking value in the irb shell
    def inspect()
      "#{self.class}:#{@seq_id}"
    end

  end
end