require '../app/services/author_service'
require '../app/services/library_service'
require '../app/services/book_service'
require_relative "../app/entity/Library"

library = LibraryService::load

puts "\n\n\tWelcome to Library App\n"

isExit = false

while isExit != true

  Library.print_instruction

  print "\nEnter command: "
  action = gets.chop

  commands = action.split(", ")

  case commands[0]
  when "Book"
    if commands[1] == "Show"
      BookService::show library
      gets
    elsif commands[1] == "Add"
      BookService::add library
      gets
    elsif commands[1] == "Delete"
      BookService::delete library
      gets
    elsif commands[1] == "Show popular"
      BookService::show_most_popular_book library
      gets
    else
      puts "\n!- Undefined command for this entity ('Book')\n"
    end

  when "Reader"
    puts "Reader"

  when "Order"
    puts "Order"

  when "Author"
    if commands[1] == "Show"
      AuthorService::show library
      gets
    elsif commands[1] == "Add"
      AuthorService::add library
      gets
    elsif commands[1] == "Delete"
      AuthorService::delete libcrary
      gets
    elsif commands[1] == "Show Books"
      AuthorService::show_books library
      gets
    else
      puts "\n!- Undefined command for this entity ('Author')\n"
    end

  when "Exit"
    LibraryService::save library
    isExit = true
    puts "Bye"
  else
    puts "\n!- Wrong COMMAND\n"
  end
end
