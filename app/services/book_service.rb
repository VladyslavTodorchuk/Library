# frozen_string_literal: true

require './entity/book'

module BookService
  class << self
    def add(library)
      book_data_hash = book_data

      new_book = new_book(book_data_hash[:author_name], book_data_hash[:book_title], library)
      return 'Files can be empty' if new_book.nil?

      '!- Book, is already exits' unless library.books.find do |book|
                                           book.title == new_book.title && book.author.name == new_book.name
                                         end

      library.books << new_book
      '!- Book, was added'
    end

    def show(library)
      books = library.books
      books.each do |book|
        puts book.to_s
      end
    end

    def BookService.delete(library)
      book_data_hash = book_data
      return '!- Book does not exits' if library.books.delete_if do |book|
                                           book.title == book_data_hash[:book_title] &&
                                           book.author.name == book_data_hash[:book_name]
                                         end

      '!- Book was deleted'
    end

    def top_popular_book(library, top_count = 3)
      books_hash = Hash.new(0)
      library.orders.each { |order| books_hash[order.book] += 1 }
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

    def new_book(author_name, book_title, library)
      return nil if book_title.empty? || author_name.empty?

      book_author = library.authors.find { |a| a.name == author_name }
      Book.new(title: book_title, author: book_author)
    end
  end
end
