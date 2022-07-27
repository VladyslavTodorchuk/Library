# frozen_string_literal: true

require './entity/order'

module OrderService
  class << self
    def add(lib)
      puts '  Add Order'
      print 'Enter Reader email: '
      reader_email = gets.chomp.strip

      print 'Enter Book title: '
      book_title = gets.chomp.strip

      print 'Enter Author name: '
      author_name = gets.chomp.strip

      book = lib.books.find { |b| b.title == book_title && b.author.name == author_name }
      reader = lib.readers.find { |r| r.email == reader_email }
      date = DateTime.now

      if book.nil? || reader.nil?
        puts '!- There is no such a book or author'
        return
      end
      search_order = Order.new([book, reader, Date.parse(date.to_s)])

      if lib.orders.find { |order| order.reader.email == reader_email && order.book.title == book_title && order.book.author.name == author_name }
        puts '!- Order, was added'
        lib.orders << search_order
      else
        puts '!- Order is already exits'
      end
    end

    def show(lib)
      puts '  Orders'
      lib.orders.each do |order|
        puts order.to_s
      end
    end

    def delete(lib)
      puts '  Delete Order'
      print 'Enter Reader email: '
      reader_email = gets.chomp.strip

      print 'Enter Book title: '
      book_title = gets.chomp.strip

      print 'Enter Author name: '
      author_name = gets.chomp.strip

      if lib.orders.delete_if { |o| o.reader.email == reader_email && o.book.title == book_title && o.book.author.name == author_name }
        puts '!- Order was deleted'
      else
        puts '!- Order was not delete or is not exits'
      end
    end
  end
end
