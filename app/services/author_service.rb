require './entity/author'

module AuthorService
  class << self
  def add(lib)
    print 'Enter name: '
    name = gets.chomp.strip
    print 'Enter biography: '
    bio = gets.chomp.strip

    if name.empty?
      puts '!- Fields can not be empty'
      return
    end

    author = Author.new([name, bio])
    if lib.authors.find {|a| a.name == author.name}
      lib.authors << author
      puts '!- Author, was added'
    else
      puts '!- Author, is already exits'
    end
  end

  def show(lib)
    authors = lib.authors
    authors.each do |author|
      puts author.to_s
    end
  end

  def delete(lib)
    print 'Enter name: '
    name = gets.chomp.strip

    if lib.authors.delete_if {|author| author.name == name}
      puts '!- Author was deleted'
    else
      puts '!- Author does not exits'
    end
  end

  def AuthorService.show_books(lib)
    print 'Enter name: '
    name = gets.chomp.strip

    author_books = lib.books.select {|book| book.author.name = name}

    unless author_books.length == 0
      author_books.each do |author_book|
      puts author_book.to_s
      end

    else
      puts '!- Author, don`t have books yet'
    end
  end
  end

end