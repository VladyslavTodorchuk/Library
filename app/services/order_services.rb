# frozen_string_literal: true

require './entity/order'

module OrderService
  class << self
    def add(lib)
      print 'Enter Reader email: '
      reader_email = gets.chomp.strip
      print 'Enter Book title: '
      book_title = gets.chomp.strip
      print 'Enter Author name: '
      author_name = gets.chomp.strip
      order_book = lib.books.find { |b| b.title == book_title && b.author.name == author_name }
      order_reader = lib.readers.find { |r| r.email == reader_email }
      order_date = DateTime.now

      return '!- There is no such a book or author' if order_book.nil? || order_reader.nil?

      new_order = Order.new(book: order_book, reader: order_reader, date: Date.parse(order_date.to_s))
      return '!- Order is already exits' if lib.orders.find do |order|
                                              order.reader.email == reader_email &&
                                              order.book.title == book_title &&
                                              order.book.author.name == author_name
                                            end

      lib.orders << new_order
      '!- Order, was added'
    end

    def show(lib)
      lib.orders.each do |order|
        puts order.to_s
      end
    end

    def delete(lib)
      print 'Enter Reader email: '
      reader_email = gets.chomp.strip
      print 'Enter Book title: '
      book_title = gets.chomp.strip
      print 'Enter Author name: '
      author_name = gets.chomp.strip
      return '!- Order was deleted' if lib.orders.delete_if do |o|
                                         o.reader.email == reader_email &&
                                         o.book.title == book_title && o.book.author.name == author_name
                                       end

      '!- Order was not delete or is not exits'
    end
  end
end
