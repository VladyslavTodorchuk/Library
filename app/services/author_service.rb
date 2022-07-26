require './entity/Author'

module AuthorService

  def AuthorService.add(lib)
    puts "\n\tAdd Author"
    print "Enter name: "
    name = gets.chomp.strip
    print "Enter biography: "
    bio = gets.chomp.strip

    author = Author.new name, bio
    if (lib.authors.select {|a| a.name == author.name}).length == 0
      lib.authors << author
      puts "\n!- Author, was added"
    else
      puts "\n!- Author, is already exits"
    end
  end

  def AuthorService.show(lib)
    puts "\n\t Authors"
    authors = lib.authors
    authors.each do |author|
      puts author.to_s
    end
  end

  def AuthorService.delete(lib)
    puts "\n\tDelete Author"
    print "Enter name: "
    name = gets.chomp.strip

    if lib.authors.delete_if {|author| author.name == name}
      puts "\n!- Author was deleted\n"
    else
      puts "\n!- Author does not exits"
    end
  end

  def AuthorService.show_books(lib)
    puts "\n\tShow Author`s books"
    print "Enter name: "
    name = gets.chomp.strip

    author_books = lib.books.select {|book| book.author.name = name}

    unless author_books.length == 0
      author_books.each do |author_book|
      puts author_book.to_s
      end

    else
      puts "\n!- Author, don`t have books yet"
    end
  end

end