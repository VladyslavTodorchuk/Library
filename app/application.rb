require '../app/services/author_service'
require '../app/services/library_service'
require '../app/services/book_service'
require '../app/services/reader_service'
require '../app/services/order_services'
require_relative "./entity/library"

private

def process_book_command(command)
  case command
  when 'show'
    puts ' Books'
    BookService::show @library
    gets
  when 'add'
    puts '  Add Book'
    BookService::add @library
    gets
  when 'delete'
    puts '  Delete Book'
    BookService::delete @library
    gets
  else
    puts '!- Undefined command for this entity ("Book")'
  end
end

def process_order_command(command)
  case command
  when 'show'
    OrderService::show @library
    gets
  when 'add'
    OrderService::add @library
    gets
  when 'delete'
    OrderService::delete @library
    gets
  else
    puts '!- Undefined command for this entity ("Order")'
  end
end

def process_author_command(command)
  case command
  when 'show'
    puts '  Authors'
    AuthorService::show @library
    gets
  when 'add'
    puts '  Add Author'
    AuthorService::add @library
    gets
  when 'delete'
    puts '  Delete Author'
    AuthorService::delete @library
    gets
  when 'show books'
    puts '  Show Author`s books'
    AuthorService::show_books @library
    gets
  else
    puts '!- Undefined command for this entity ("Author")'
  end
end

def process_reader_command(command)
  case command
  when 'show'
    puts ' Readers'
    ReaderService::show @library
    gets
  when 'add'
    puts ' Reader'
    ReaderService::add @library
    gets
  when 'delete'
    puts '  Delete Reader'
    ReaderService::delete @library
    gets
  when 'show books'
    puts '  Orders'
    ReaderService::show_books @library
    gets
  else
    puts '!- Undefined command for this entity ("Reader")'
  end
end

def process_statistics
  puts "\n\tStatistics"

  puts "\n\tTop Books"
  top_book = BookService::top_popular_book @library
  ReaderService::reader @library, top_book, 2

  readers_hash = ReaderService::most_popular_book @library

  puts "\n\tMost Popular Reader"
  readers_hash.each do |reader, value|
    puts "| #{reader.name}, #{reader.email} with #{value} books"
  end

  books = BookService::top_popular_book @library, 1
  puts "\n\tThe most popular Book"
  books.each do |book, v|
    puts "#{book} count of readers: #{v}"
  end
  gets
end

@library = LibraryService::load
puts '    Welcome to Library App'
is_exit = false

until is_exit

  @library.print_instruction
  print ' Enter command: '
  action = gets.chop.downcase
  commands = action.split(", ")

  case commands[0]
  when 'book' then process_book_command(commands[1])

  when 'reader' then process_reader_command(commands[1])

  when 'order' then process_order_command(commands[1])

  when 'author' then process_author_command(commands[1])

  when 'statistics' then process_statistics

  when 'exit'
    LibraryService::save @library
    is_exit = true
    puts 'Bye'
  else
    puts '!- Wrong COMMAND'
  end
end
