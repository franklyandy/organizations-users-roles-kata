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
    return @parent = parent unless is_root_organization?
    raise ArgumentError, "root organization cannot have a parent"
  end

  private

    def is_root_organization?
      self.depth == ROOT
    end

end
