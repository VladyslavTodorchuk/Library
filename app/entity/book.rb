class Book
  attr_accessor :title, :author

  def initialize(params)
    @title = params[:title]
    @author = params[:author]
  end

  def to_s
    "Title: #{@title} Author: #{@author.name}"
  end

  def ==(other)
    @title == other.title && @author == other.author if other.nil? || !other.instance_of?(Book)
  end
end

