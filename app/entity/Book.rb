class Book
  attr_accessor :title, :author

  def initialize(title, author)
    @title = title
    @author = author
  end

  def to_s
    "Title: #{@title} Author: #{@author.name}"
  end

  def ==(other)
    if other.nil? || !other.instance_of?(Book)
      false
    else
      @title == other.title && @author == other.author
    end
  end
end

