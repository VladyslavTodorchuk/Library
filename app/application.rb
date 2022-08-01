# frozen_string_literal: true

require '../app/services/author_service'
require '../app/services/library_service'
require '../app/services/book_service'
require '../app/services/reader_service'
require '../app/services/order_services'
require_relative './entity/library'

private

def process_book_command(command)
  case command
  when 'show' then BookService.show @library
  when 'add' then puts BookService.add @library
  when 'delete' then puts BookService.delete @library
  else
    puts '!- Undefined command for this entity ("Book")'
  end
end

def process_order_command(command)
  case command
  when 'show' then OrderService.show @library
  when 'add' then  puts OrderService.add @library
  when 'delete' then puts OrderService.delete @library
  else
    puts '!- Undefined command for this entity ("Order")'
  end
end

def process_author_command(command)
  case command
  when 'show' then AuthorService.show @library
  when 'add' then puts AuthorService.add @library
  when 'delete' then puts AuthorService.delete @library
  when 'show books' then  AuthorService.show_books @library
  else
    puts '!- Undefined command for this entity ("Author")'
  end
end

def process_reader_command(command)
  case command
  when 'show' then ReaderService.show @library
  when 'add' then puts ReaderService.add @library
  when 'delete' then puts ReaderService.delete @library
  when 'show books' then  ReaderService.show_books @library
  else
    puts '!- Undefined command for this entity ("Reader")'
  end
end

@library = LibraryService.load
puts '    Welcome to Library App'
is_exit = false

until is_exit

  @library.print_instruction
  print ' Enter command: '
  action = gets.chop.downcase
  commands = action.split(', ')

  case commands[0]
  when 'book' then process_book_command(commands[1])

  when 'reader' then process_reader_command(commands[1])

  when 'order' then process_order_command(commands[1])

  when 'author' then process_author_command(commands[1])

  when 'statistics' then @library.print_statistics

  when 'exit'
    LibraryService.save @library
    is_exit = true
    puts 'Bye'
  else
    puts '!- Wrong COMMAND'
  end
end
