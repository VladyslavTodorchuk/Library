require './entity/Reader'

module ReaderService

  def ReaderService.add(lib)
    puts "\n\tAdd Reader"
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

    reader = Reader.new name, email, city, street, house
    if (lib.readers.select {|r| r.email == reader.email}).length == 0
      lib.readers << reader
      puts "\n!- Reader, was added"
    else
      puts "\n!- Reader, is already exits"
    end

  end

  def ReaderService.show(lib)
    puts "\n\t Readers"
    readers = lib.readers
    readers.each do |reader|
      puts reader.to_s
    end
  end

  def ReaderService.delete(lib)
    puts "\n\tDelete Reader"
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
    puts "\n\tOrders"
    print "Enter email: "
    email = gets.chomp.strip

    lib.orders.select {|order| order.reader.email == email}.each do |order|
      puts order
    end
  end

  def ReaderService.top_reader(lib)

    reader_hash = Hash.new(0)
    lib.orders.each {|order| reader_hash[order.reader] += 1}
    if reader_hash.length == 0
      puts "There is no finner yet"
    else
      reader = reader_hash.max_by { |_reader, number| number}[0]
      puts "The reader with the most books is #{reader.name} with #{reader_hash[reader]} books"
    end

  end

end