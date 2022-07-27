class Order
  attr_accessor :book, :reader, :date

  def initialize(params)
    @book = params[:book]
    @reader = params[:reader]
    @date = params[:date]
  end

  def to_s
    "|Order| Book: #{@book.title} Reader: #{@reader.name} '#{@reader.email}' #{@date}"
  end
end

