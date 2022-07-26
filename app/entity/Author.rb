
class Author
  attr_accessor :name, :biography

  def initialize(name, biography)
    @name = name
    @biography = biography
  end

  def to_s
    "Name: #{@name} Biography: #{@biography}"
  end

  def ==(other)
    if other.nil? || !other.instance_of?(Author)
      false
    else
      @name == other.name && biography == other.biography
    end
  end
end

