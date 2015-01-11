class Organization
  attr_accessor :depth

  def depth=(depth)
    raise ArgumentError, "depth can only be 0, 1, or 2" if depth < 0
    @depth = depth
  end
end
