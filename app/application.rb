require '../app/services/author_service'
require './entity/Author'
require './entity/Book'
require './entity/Order'
require './entity/Reader'
require 'date'

class Library

  attr_accessor :authors, :books, :readers, :orders

  def initialize
    @authors = []
    @readers = []
    @books = []
    @orders = []
  end

  def find_top_reader
  end

  def find_most_popular_book
  end

  def get_number_of_readers_of_most_popular_book
  end

  def save
    json_name = "../json/data.json"
    json_new = json_name + ".new"
    json_old = json_name + ".old"

    data_hash = {:Authors=> [], :Books => [], :Readers => [], :Orders => []}

    @authors.each do |author|
      data_hash[:Authors] << {name: author.name, biography: author.biography}
    end

    @books.each do |book|
      data_hash[:Books] << {title: book.title, author: { name: book.author.name, biography: book.author.biography }}
    end

    @readers.each do |reader|
      data_hash[:Readers] << {name: reader.name, email: reader.email, city: reader.city, street: reader.street, house: reader.house}
    end

    @orders.each do |order|
      data_hash[:Orders] << {book: {title: order.book.title, author: {name: order.book.author.name, biography: order.book.author.biography}},
                                reader: {name: order.reader.name, email: order.reader.email, city: order.reader.city, street: order.reader.street, house: order.reader.house},
                                date: order.date}
    end
    File.write(json_new, JSON.pretty_generate(data_hash))

    File.rename(json_name, json_old)
    File.rename(json_new, json_name)
    File.delete(json_old)

  end

  def load
    File.open("../json/data.json") do |file|
      date_hash = JSON.parse(file.read)

      # puts date_hash

      author_hash = date_hash["Authors"]
      books_hash = date_hash["Books"]
      readers_hash = date_hash["Readers"]
      orders_hash = date_hash["Orders"]

      author_hash.each do |elem|
        @authors.push(Author.new(elem["name"], elem["biography"]))
      end

      books_hash.each do |elem|
        @books.push(Book.new(elem["title"], Author.new(elem["author"]["name"], elem["author"]["biography"])))
      end

      readers_hash.each do |elem|
        @readers.push(Reader.new(elem["name"], elem["email"], elem["city"], elem["street"], elem["house"]))
      end

      orders_hash.each do |elem|
        @orders.push(Order.new(Book.new(elem["book"]["title"], Author.new(elem["book"]["author"]["name"], elem["book"]["author"]["biography"])),
                     Reader.new(elem["reader"]["name"], elem["reader"]["email"], elem["reader"]["city"], elem["reader"]["street"], elem["reader"]["house"]),
                               Date.parse(elem["date"])))
      end
    end
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

library = Library.new
library.load
puts "\n\n\tWelcome to Library App\n"

isExit = false

while isExit != true

  Library.print_instruction

  print "\nEnter command: "
  action = gets.chop

  commands = action.split(", ")

  case commands[0]
  when "Book"
    puts "Book"

  when "Reader"
    puts "Reader"

  when "Order"
    puts "Order"

  when "Author"
    if commands[1] == "Show"
      puts "\n\t Authors"
      authors = library.authors
      authors.each do |author|
        author.to_s
      end
      gets
    elsif commands[1] == "Add"
      # Check if Author is already exits
      puts "\n\tAdd Author:"
      print "Name: "
      name = gets.chomp
      print "Biography: "
      bio = gets.chomp

      library.authors << Author.new(name, bio)
      puts "\n!- Author was added\n"

      gets

    elsif commands[1] == "Delete"
      # Check if Author is not exits
      puts "\n\tDelete Author"
      print "Enter name: "
      name = gets.chomp

      print "Biography: "
      bio = gets.chomp

      library.authors.delete_if {|author| author.name == name && author.biography == bio}
      puts "\n!- Author was deleted\n"


    elsif commands[1] == "Show Books"
      puts "Show Books"
    else
      puts "\n!- Undefined command for this entity\n"
    end

  when "Exit"
    library.save
    isExit = true
    puts "Bye"
  else
    puts "\n!- Wrong COMMAND\n"
  end
end
