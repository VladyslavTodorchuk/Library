require_relative 'author'
require_relative 'book'
require_relative 'order'
require_relative 'reader'
require 'yaml'
require 'date'

class Library

  attr_accessor :authors, :books, :readers, :orders

  def print_instruction
    puts '(Write command by typing <entity, command>)  Chose action:'
    puts '  Author         Book                       Reader          Order       Statistics'
    puts '1) Add         1) Add                     1) Add          1) Add      1) Statistics'
    puts '2) Show        2) Show                    2) Show         2) Show'
    puts '3) Show Books                                       '
    puts '4) Delete      4) Delete                  4) Delete       4) Delete'
  end

  def print_statistics
    book = find_most_popular_book
    puts "\t\nStatistics\n Most popular book is #{book[0]} count of readers: #{book[1]}"
  end

  def find_most_popular_book
    books_hash = {}
    @orders.each do |order|
      books_hash[order.book] += 1
    end
    book = books_hash.max_by { |_k, v| v }.first
    count_of_readers = books_hash[book]
    { book:, count_of_readers: }
  end

end

