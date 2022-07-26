require '../app/services/author_service'
require '../app/services/library_service'
require '../app/services/book_service'
require '../app/services/reader_service'
require '../app/services/order_services'
require_relative "../app/entity/Library"

library = LibraryService::load

puts "\n\n\tWelcome to Library App\n"

isExit = false

while isExit != true

  library.print_instruction

  print "\nEnter command: "
  action = gets.chop.downcase

  commands = action.split(", ")

  case commands[0]
  when "book"
    if commands[1] == "show"
      puts "\n\t Books"
      BookService::show library
      gets
    elsif commands[1] == "add"
      puts "\n\tAdd Book"
      BookService::add library
      gets
    elsif commands[1] == "delete"
      puts "\n\tDelete Book"
      BookService::delete library
      gets
    else
      puts "\n!- Undefined command for this entity ('Book')\n"
    end

  when "reader"
    if commands[1] == "show"
      puts "\n\t Readers"
      ReaderService::show library
      gets
    elsif commands[1] == "add"
      puts "\n\tAdd Reader"
      ReaderService::add library
      gets
    elsif commands[1] == "delete"
      puts "\n\tDelete Reader"
      ReaderService::delete library
      gets
    elsif commands[1] == "show books"
      puts "\n\tOrders"
      ReaderService::show_books library
      gets
    else
      puts "\n!- Undefined command for this entity ('Reader')\n"
    end

  when "order"
    if commands[1] == "show"
      OrderService::show library
      gets
    elsif commands[1] == "add"
      OrderService::add library
      gets
    elsif commands[1] == "delete"
      OrderService::delete library
      gets
    else
      puts "\n!- Undefined command for this entity ('Order')\n"
    end

  when "author"
    if commands[1] == "show"
      puts "\n\t Authors"
      AuthorService::show library
      gets
    elsif commands[1] == "add"
      puts "\n\tAdd Author"
      AuthorService::add library
      gets
    elsif commands[1] == "delete"
      puts "\n\tDelete Author"
      AuthorService::delete library
      gets
    elsif commands[1] == "show books"
      puts "\n\tShow Author`s books"
      AuthorService::show_books library
      gets
    else
      puts "\n!- Undefined command for this entity ('Author')\n"
    end
  when "statistics"
    puts "\n\tStatistics"

    puts "\n\tTop Books"
    top_book = BookService::top_popular_book library
    ReaderService::reader library, top_book, 2

    readers_hash = ReaderService::most_popular_book library

    puts "\n\tMost Popular Reader"
    readers_hash.each do |reader,_value|
      puts "| #{reader.name}, #{reader.email}"
    end

    books = BookService::top_popular_book library, 1
    puts "\n\tThe most popular Book"
    books.each do |book, v|
      puts "#{book} count of readers: #{v}"
    end
    gets
  when "exit"
    LibraryService::save library
    isExit = true
    puts "Bye"
  else
    puts "\n!- Wrong COMMAND\n"
  end
end
