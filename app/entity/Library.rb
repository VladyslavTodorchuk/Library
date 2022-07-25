require_relative 'Author'
require_relative 'Book'
require_relative 'Order'
require_relative 'Reader'
require 'yaml'
require 'date'

class Library

  attr_accessor :authors, :books, :readers, :orders

  def find_top_reader
  end

  def find_most_popular_book
  end

  def get_number_of_readers_of_most_popular_book
  end

  def self.print_instruction

    puts "(Write command by typing <entity, command>) \n Chose action:"
    puts "  Author         Book                       Reader          Order"
    puts "1) Add         1) Add                     1) Add          1) Add"
    puts "2) Show        2) Show                    2) Show         2) Show"
    puts "3) Show Books  3) Show most popular book  3) Show Books"
    puts "4) Delete      4) Delete                  4) Delete       4) Delete"

  end
end

