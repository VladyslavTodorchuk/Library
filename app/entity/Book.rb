class Book
  attr_accessor :title, :author

  def initialize(title, author)
    @title = title
    @author = author
  end

  def to_s
    "Title: #{@title} Author: #{@author.name}"
  end
end

