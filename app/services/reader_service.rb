# frozen_string_literal: true

require './entity/reader'

module ReaderService
  class << self
    def add(lib)
      print 'Enter Name: '
      reader_name = gets.chomp.strip
      print 'Enter Email: '
      reader_email = gets.chomp.strip
      print 'Enter City: '
      reader_city = gets.chomp.strip
      print 'Enter Street and House'
      reader_street = gets.chomp.strip
      print 'Enter House: '
      reader_house = gets.chomp.to_i
      return '!- Fields can not be empty' if reader_name.empty? || reader_email.empty? || reader_city.empty? ||
                                             reader_street.empty? || reader_house.negative?

      reader = Reader.new(name: reader_name, email: reader_email, city: reader_city,
                          street: reader_street, house: reader_house)

      return '!- Reader, is already exits' if lib.readers.find { |r| r.email == reader.email }

      lib.readers << reader
      '!- Reader, was added'
    end

    def show(lib)
      readers = lib.readers
      readers.each do |reader|
        puts reader.to_s
      end
    end

    def delete(lib)
      print 'Enter email: '
      reader_email = gets.chomp.strip
      return '!- Reader was deleted' if lib.readers.delete_if { |reader| reader.email == reader_email }
      return '!- Reader does not exits' unless lib.readers.delete_if { |reader| reader.email == reader_email }

      '!- Can`t delete reader he has order'
    end

    def show_books(lib)
      print 'Enter email: '
      reader_email = gets.chomp.strip
      lib.orders.select { |order| order.reader.email == reader_email }.each do |order|
        puts order
      end
    end

    def reader(lib, top_books, top_count = 1)
      top_books.each do |book, _v|
        orders = lib.orders.select { |order| order.book == book }.first(top_count)
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
