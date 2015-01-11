class Organization
  MIN_DEPTH = 0
  MAX_DEPTH = 2

  attr_accessor :depth

  def depth=(depth)
    return @depth = depth if depth.between?(MIN_DEPTH, MAX_DEPTH)
    raise ArgumentError, "depth must be between #{MIN_DEPTH} and #{MAX_DEPTH}"
  end
end
