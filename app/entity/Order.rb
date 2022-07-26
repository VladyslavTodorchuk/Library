class Order
  attr_accessor :book, :reader, :date

  def initialize(book, reader, date)
    @book = book
    @reader = reader
    @date = date
  end

  def to_s
    "|Order| Book: #{@book.title} Reader: #{@reader.name} '#{@reader.email}' #{@date}"
  end
end

