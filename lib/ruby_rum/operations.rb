module Operations

  def is_a_number?(string)
    s.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
  end

  def is_in_range?(num1, num2, distance)
    dis = (num2-num1).abs
    dis <= distance
  end

  # seperates a file in 10Mb chunks and returns random.number_of_chunks
  def seperate_file(filename, tmp_folder_name)
    handler = File.open(filename,'r')


  end

end