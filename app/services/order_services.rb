# frozen_string_literal: true

require './entity/order'

module OrderService
  class << self
    def add(library)
      user_data_hash = order_data
      new_order = new_order(library, user_data_hash)

      return '!- No such book or author' if new_order.nil?

      return '!- Order is already exits' if find_order(library, user_data_hash)

      library.orders << new_order
      '!- Order, was added'
    end

    def show(library)
      library.orders.each do |order|
        puts order.to_s
      end
    end

    def delete(library)
      order_data_hash = order_data
      return '!- Order was deleted' if library.orders.delete_if do |o|
                                         o.reader.email == order_data_hash[:reader_email] &&
                                         o.book.title == order_data_hash[:book_title] &&
                                         o.book.author.name == order_data_hash[:author_name]
                                       end

      '!- Order was not delete or is not exits'
    end

    private

    def order_data
      print 'Enter Reader email: '
      reader_email = gets.chomp.strip
      print 'Enter Book title: '
      book_title = gets.chomp.strip
      print 'Enter Author name: '
      author_name = gets.chomp.strip
      { reader_email:, book_title:, author_name: }
    end

    def new_order(library, user_hash)
      order_book = order_book(library, user_hash[:book_title], user_hash[:author_name])
      order_reader = library.readers.find { |r| r.email == user_hash[:reader_email] }
      order_date = DateTime.now
      return nil if order_book.nil? || order_reader.nil?

      Order.new(book: order_book, reader: order_reader, date: Date.parse(order_date.to_s))
    end

    def order_book(library, book_title, author_name)
      library.books.find do |b|
        b.title == book_title &&
          b.author.name == author_name
      end
    end

    def find_order(library, user_data_hash)
      library.orders.find do |order|
        order.reader.email == user_data_hash[:reader_email] &&
          order.book.title == user_data_hash[:book_title] &&
          order.book.author.name == user_data_hash[:author_name]
      end
    end
  end
end
