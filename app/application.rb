require '../app/services/author_service'
require '../app/services/library_service'
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

      library.authors.delete_if {|author| author.name == name}
      puts "\n!- Author was deleted\n"


    elsif commands[1] == "Show Books"
      puts "Show Books"
    else
      puts "\n!- Undefined command for this entity\n"
    end

  when "Exit"
    LibraryService::save library
    isExit = true
    puts "Bye"
  else
    puts "\n!- Wrong COMMAND\n"
  end
end
