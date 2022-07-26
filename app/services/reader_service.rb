require './entity/Reader'

module ReaderService

  def ReaderService.add(lib)
    print "Enter Name: "
    name = gets.chomp.strip
    print "Enter Email: "
    email = gets.chomp.strip
    print "Enter City: "
    city = gets.chomp.strip
    print "Enter Street: "
    street = gets.chomp.strip
    print "Enter House: "
    house = gets.chomp.to_i
    if name == "" || email == "" || city == "" || street == "" || house < 0
      puts "\n!- Fields can not be empty"
      return
    end
    reader = Reader.new name, email, city, street, house
    if (lib.readers.select {|r| r.email == reader.email}).length == 0
      lib.readers << reader
      puts "\n!- Reader, was added"
    else
      puts "\n!- Reader, is already exits"
    end
  end

  def ReaderService.show(lib)
    readers = lib.readers
    readers.each do |reader|
      puts reader.to_s
    end
  end

  def ReaderService.delete(lib)
    print "Enter email: "
    email = gets.chomp.strip

    if lib.orders.select {|o| o.reader.email == email}.length == 0
      if lib.readers.delete_if {|reader| reader.email == email}
        puts "\n!- Reader was deleted\n"
      else
        puts "\n!- Reader does not exits"
      end
    else
      puts "\n!- Can`t delete reader he has order"
    end

  end

  def ReaderService.show_books(lib)
    print "Enter email: "
    email = gets.chomp.strip

    lib.orders.select {|order| order.reader.email == email}.each do |order|
      puts order
    end
  end

  def ReaderService.top_reader(lib, top_books, top_count = 1)
    top_books.each do |book, _v|
      orders = lib.orders.select {|order| order.book == book}.first top_count
      puts book.to_s
      tmp = nil
      orders.each do |e|
        puts "\t |#{e.reader.name} #{e.reader.email}" unless !tmp.nil? && tmp.email == e.reader.email
        tmp = orders[0].reader
      end
    end
  end

end