module Operations

  def is_a_number?(string)
    s.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
  end

  def is_in_range?(num1, num2, distance)
    dis = (num2-num1).abs
    dis <= distance
  end

end