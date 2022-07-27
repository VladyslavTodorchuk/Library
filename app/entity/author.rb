# frozen_string_literal: true

class Author
  attr_accessor :name, :biography

  def initialize(params)
    @name = params[:name]
    @biography = params[:biography]
  end

  def to_s
    "Name: #{@name} Biography: #{@biography}"
  end

  def ==(other)
    @name == other.name && biography == other.biography if other.nil? || !other.instance_of?(Author)
  end
end
