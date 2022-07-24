require '../app/services/author_service'


class Library

  attr_accessor :authors, :books, :readers, :orders

  def initialize
    @authors = AuthorService::get_all_authors
  end
  #search in array top reader
  def find_top_reader

  end

  def find_most_popular_book

  end

  def get_number_of_readers_of_most_popular_book

  end

  def update
    @authors = AuthorService::get_all_authors
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

      if AuthorService::add_author? name, bio
        puts "\n!- Author was added\n"
      else
        puts "\n!- Error!, Something went wrong\n"
      end
      library.update
      gets

    elsif commands[1] == "Delete"
      # Check if Author is not exits
      puts "\n\tDelete Author"
      print "Enter name: "
      name = gets.chomp
      print "Enter biography: "
      bio = gets.chomp
      if AuthorService.delete_author?(Author.new name, bio)
        library.update
        puts "\n!- Author was deleted\n"
      else
        puts "\n!- Error!, Something went wrong\n\t"
      end

    elsif commands[1] == "Show Books"
      puts "Show Books"
    else
      puts "\n!- Undefined command for this entity\n"
    end

  when "Exit"
    isExit = true
    puts "Bye"
  else
    puts "\n!- Wrong COMMAND\n"
  end
end
