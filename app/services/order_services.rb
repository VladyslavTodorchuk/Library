require './entity/Order'

module OrderService

  def OrderService.add(lib)
    puts "\n\tAdd Order"
    print "Enter Reader email: "
    reader_email = gets.chomp.strip

    print "Enter Book title: "
    book_title = gets.chomp.strip

    print "Enter Author name: "
    author_name = gets.chomp.strip

    book = lib.books.select {|b| b.title == book_title && b.author.name == author_name}[0]
    reader = lib.readers.select {|r| r.email == reader_email}[0]
    date = DateTime.now

    if book == nil || reader == nil
      puts "\n!- There is no such a book or author"
      return
    end
    order = Order.new book, reader, Date.parse(date.to_s)

    if lib.orders.select {|order| order.reader.email == reader_email && order.book.title == book_title && order.book.author.name == author_name}.length == 0
      puts "\n!- Order, was added"
      lib.orders << order
    else
      puts "\n!- Order is already exits"
    end

  end

  def OrderService.show(lib)
    puts "\n\tOrders"
    lib.orders.each do |order|
      puts order.to_s
    end
  end

  def OrderService.delete(lib)
    puts "\n\tDelete Order"
    print "Enter Reader email: "
    reader_email = gets.chomp.strip

    print "Enter Book title: "
    book_title = gets.chomp.strip

    print "Enter Author name: "
    author_name = gets.chomp.strip

    if lib.orders.delete_if {|o| o.reader.email == reader_email && o.book.title == book_title && o.book.author.name == author_name}
      puts "\n!- Order was deleted"
    else
      puts "\n!- Order was not delete or is not exits"
    end
  end


end