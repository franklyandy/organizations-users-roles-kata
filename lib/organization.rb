class Organization
  MIN_DEPTH = 0
  MAX_DEPTH = 2
  ROOT = MIN_DEPTH

  attr_accessor :parent

  def initialize(parent = Organization.new(nil))
    @is_root = parent.nil?
    self.parent = parent
  end

  def depth
    return 0 if self.is_root?
  end

  def is_child_organization?
    self.depth == MAX_DEPTH
  end

  def is_root?
    @is_root
  end

  def parent=(parent)
    if self.is_root? && !parent.nil?
      raise ArgumentError, "root organization cannot have a parent"
    elsif !parent.nil? && parent.is_child_organization?
      raise ArgumentError, "a child organization cannot be a parent"
    end
    @parent = parent
  end

  private

    def is_root_organization?
      self.depth == ROOT
    end

end
