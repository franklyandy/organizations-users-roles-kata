class Organization
  MIN_DEPTH = 0
  MAX_DEPTH = 2
  ROOT = MIN_DEPTH

  attr_accessor :depth
  attr_accessor :parent

  def depth=(depth)
    return @depth = depth if depth.between?(MIN_DEPTH, MAX_DEPTH)
    raise ArgumentError, "depth must be between #{MIN_DEPTH} and #{MAX_DEPTH}"
  end

  def parent=(parent)
    raise ArgumentError, "root organization cannot have a parent"
  end
end
