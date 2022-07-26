# frozen_string_literal: true

class Author
  attr_reader :name, :bio

  def initialize(params)
    @name = params[:name]
    @bio = params[:bio]
  end

  def to_s
    "Name: #{@name} Biography: #{bio}"
  end

  def ==(other)
    return false if other.nil? || !other.instance_of?(Author)

    @name == other.name && bio == other.bio
  end
end
