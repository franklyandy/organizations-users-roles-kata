class Organization
  attr_accessor :parent

  def initialize(parent = Organization.new(nil))
    @is_root = parent.nil?
    self.parent = parent
  end

  def depth
    return 0 if self.is_root?
    parent.depth + 1
  end

  def is_child?
    self.depth == 2
  end

  def is_root?
    @is_root
  end

  def parent=(parent)
    if self.is_root? && !parent.nil?
      raise ArgumentError, "root organization cannot have a parent"
    elsif !parent.nil? && parent.is_child?
      raise ArgumentError, "a child organization cannot be a parent"
    end
    @parent = parent
  end

end
