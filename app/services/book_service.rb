# frozen_string_literal: true

require './entity/book'

module BookService
  class << self
    def add(lib)
      print 'Enter Title: '
      title = gets.chomp.strip
      print 'Enter Author name: '
      name = gets.chomp.strip

      if title.empty? || name.empty?
        puts '!- Fields can not be empty'
        return
      end

      order_author = lib.authors.find { |a| a.name == name }
      order_book = Book.new({ title: title, author: name })
      if lib.books.find { |book| book.title == order_book.title && book.author.name == order_author.name }
        lib.books << book
        puts '!- Book, was added'
      else
        puts '!- Book, is already exits'
      end
    end

    def show(lib)
      books = lib.books
      books.each do |book|
        puts book.to_s
      end
    end

    def BookService.delete(lib)
      print 'Enter Title: '
      title = gets.chomp.strip

      print 'Enter Author name: '
      name = gets.chomp.strip

      if lib.books.delete_if { |book| book.title == title && book.author.name == name }
        puts '!- Book was deleted'
      else
        puts '!- Book does not exits'
      end
    end

    def top_popular_book(lib, top_count = 3)
      books_hash = Hash.new(0)
      lib.orders.each { |order| books_hash[order.book] += 1 }

      if books_hash.length.zero?
        books_hash
      else
        books_hash.sort_by { |_book, number| -number }.first top_count
      end
    end
  end
end
