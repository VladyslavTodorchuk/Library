# frozen_string_literal: true

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
    return false if other.nil? || !other.instance_of?(Book)

    @title == other.title && author == other.author
  end
end
