# frozen_string_literal: true

require './entity/reader'

module ReaderService
  class << self
    def add(lib)
      print 'Enter Name: '
      name = gets.chomp.strip
      print 'Enter Email: '
      email = gets.chomp.strip
      print 'Enter City: '
      city = gets.chomp.strip
      print 'Enter Street: '
      street = gets.chomp.strip
      print 'Enter House: '
      house = gets.chomp.to_i
      if name.empty? || email.empty? || city.empty? || street.empty? || house.negative?
        puts '!- Fields can not be empty'
        return
      end
      reader = Reader.new({ name: name, email: email, city: city, street: street, house: house})
      if lib.readers.find { |r| r.email == reader.email }
        puts '!- Reader, is already exits'
      else
        lib.readers << reader
        puts '!- Reader, was added'
      end
    end

    def show(lib)
      readers = lib.readers
      readers.each do |reader|
        puts reader.to_s
      end
    end

    def delete(lib)
      print 'Enter email: '
      email = gets.chomp.strip

      if lib.orders.find { |o| o.reader.email == email }
        if lib.readers.delete_if { |reader| reader.email == email }
          puts '!- Reader was deleted'
        else
          puts '!- Reader does not exits'
        end
      else
        puts '!- Can`t delete reader he has order'
      end
    end

    def show_books(lib)
      print 'Enter email: '
      email = gets.chomp.strip

      lib.orders.select { |order| order.reader.email == email }.each do |order|
        puts order
      end
    end

    def reader(lib, top_books, top_count = 1)
      top_books.each do |book, _v|
        orders = lib.orders.select { |order| order.book == book }.first top_count
        puts book.to_s
        orders.each do |e|
          puts "\t |#{e.reader.name} #{e.reader.email}"
        end
      end
    end

    def most_popular_book(lib, top_count = 1)
      readers_hash = Hash.new(0)
      lib.orders.each { |order| readers_hash[order.reader] += 1 }
      readers_hash.first top_count
    end
  end
end
