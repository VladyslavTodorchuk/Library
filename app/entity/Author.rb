require_relative  'Person'

class Author < Person
  attr_accessor :biography

  def initialize(name, biography)
    super(name)
    @biography = biography
  end

  def to_s
    puts "Name: #{@name} Biography: #{@biography}"
  end
end

