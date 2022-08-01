# frozen_string_literal: true

require './entity/book'

module BookService
  class << self
    def add(lib)
      book_data_hash = book_data

      new_book = new_book(book_data_hash[:author_name], book_data_hash[:book_title], lib)
      return 'Files can be empty' if new_book.nil?

      '!- Book, is already exits' unless lib.books.find do |book|
                                           book.title == new_book.title && book.author.name == new_book.name
                                         end

      lib.books << new_book
      '!- Book, was added'
    end

    def show(lib)
      books = lib.books
      books.each do |book|
        puts book.to_s
      end
    end

    def BookService.delete(lib)
      book_data_hash = book_data
      return '!- Book does not exits' if lib.books.delete_if do |book|
                                           book.title == book_data_hash[:book_title] &&
                                           book.author.name == book_data_hash[:book_name]
                                         end

      '!- Book was deleted'
    end

    def top_popular_book(lib, top_count = 3)
      books_hash = Hash.new(0)
      lib.orders.each { |order| books_hash[order.book] += 1 }
      if books_hash.length.zero?
        {}
      else
        books_hash.sort_by { |_book, number| -number }.first(top_count)
      end
    end

    private

    def book_data
      print 'Enter Title: '
      book_title = gets.chomp.strip
      print 'Enter Author name: '
      author_name = gets.chomp.strip
      { book_title:, author_name: }
    end

    def new_book(author_name, book_title, lib)
      return nil if book_title.empty? || :author_name.empty?

      book_author = lib.authors.find { |a| a.name == author_name }
      Book.new(title: book_title, author: book_author)
    end
  end
end
