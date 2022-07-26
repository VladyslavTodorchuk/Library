require './entity/Book'
require 'json'

module BookService

  def BookService.add(lib)
    puts "\n\tAdd Book"
    print "Enter Title: "
    title = gets.chomp.strip
    print "Enter Author name: "
    name = gets.chomp.strip

    author = lib.authors.select {|a| a.name == name}[0]
    book = Book.new title, author
    if (lib.books.select {|b| b.title == book.title && b.author.name == book.author.name}).length == 0
      lib.books << book
      puts "\n!- Book, was added"
    else
      puts "\n!- Book, is already exits"
    end

  end

  def BookService.show(lib)
    puts "\n\t Books"
    books = lib.books
    books.each do |book|
      puts book.to_s
    end
  end

  def BookService.delete(lib)
    puts "\n\tDelete Book"
    print "Enter Title: "
    title = gets.chomp.strip

    print "Enter Author name: "
    name = gets.chomp.strip

    if lib.books.delete_if {|book| book.title == title && book.author.name == name}
      puts "\n!- Book was deleted\n"
    else
      puts "\n!- Book does not exits"
    end
  end

  def BookService.show_most_popular_book(lib)
    books_hash = Hash.new(0)
    lib.orders.each {|order| books_hash[order.book] += 1}
    unless books_hash.length == 0
      book = books_hash.sort_by { |_book,number| number}.last[0]
      puts "The most popular book is #{book.title}, #{book.author.name} with #{books_hash[book]} readers"
    else
      puts "There is no orders yet"
    end
  end



end