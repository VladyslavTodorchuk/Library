class Book
  attr_accessor :title, :author

  def initialize(title, author)
    @title = title
    @author = author
  end
end

class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class Reader < Person
  attr_accessor :email, :city, :street, :house

  def initialize(name, email, city, street, house)
    super name
    @email = email
    @city = city
    @street = street
    @house = house
  end
end

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

class Order
  attr_accessor :book, :reader, :date

  def initialize(book, reader, date)
    @book = book
    @reader = reader
    @date = date
  end
end

