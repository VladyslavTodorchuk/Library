# frozen_string_literal: true

class Author
  attr_accessor :name, :bio

  def initialize(params)
    @name = params[:name]
    @bio = params[:bio]
  end

  def to_s
    "Name: #{@name} Biography: #{bio}"
  end

  def ==(other)
    @name == other.name && bio == other.bio if other.nil? || !other.instance_of?(Author)
  end
end
