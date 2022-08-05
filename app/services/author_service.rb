# frozen_string_literal: true

require './entity/author'

module AuthorService
  class << self
    def add(library)
      print 'Enter name: '
      author_name = gets.chomp.strip
      print 'Enter biography: '
      author_bio = gets.chomp.strip
      return '!- Fields can not be empty' if author_name.empty?

      new_author = Author.new(name: author_name, bio: author_bio)
      return '!- Author, is already exits' if library.authors.find { |a| a.name == new_author.name }

      library.authors << new_author
      '!- Author, was added'
    end

    def show(library)
      authors = library.authors
      authors.each do |author|
        puts author.to_s
      end
    end

    def delete(library)
      print 'Enter name: '
      author_name = gets.chomp.strip
      return '!- Author was deleted' if library.authors.delete_if { |author| author.name == author_name }

      '!- Author does not exits'
    end

    def self.show_books(library)
      print 'Enter name: '
      author_name = gets.chomp.strip
      author_books = library.books.select { |book| book.author.name = author_name }
      author_books.each do |author_book|
        puts author_book.to_s
      end
    end
  end
end
