# frozen_string_literal: true

require_relative 'author'
require_relative 'book'
require_relative 'order'
require_relative 'reader'
require 'yaml'
require 'date'

class Library
  attr_reader :authors, :books, :readers, :orders

  def print_instruction
    puts '(Write command by typing <entity, command>)  Chose action:'
    puts '  Author         Book                       Reader          Order       Statistics'
    puts '1) Add         1) Add                     1) Add          1) Add      1) Statistics'
    puts '2) Show        2) Show                    2) Show         2) Show'
    puts '3) Show Books'
    puts '4) Delete      4) Delete                  4) Delete       4) Delete'
  end

  def print_statistics
    puts 'Top Books'
    find_top_books(3, 1)
    puts 'Top Reader'
    most_popular_reader
    puts 'Most Popular Book'
    find_top_books(1, 0)
  end

  def find_top_books(count_books, count_reader)
    top_book = BookService.top_popular_book self, count_books
    ReaderService.reader self, top_book, count_reader
  end

  def most_popular_reader
    readers_hash = ReaderService.most_popular_book self
    readers_hash.each do |reader, value|
      puts "| #{reader.name}, #{reader.email} with #{value} books"
    end
  end
end
