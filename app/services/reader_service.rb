# frozen_string_literal: true

require './entity/reader'

module ReaderService
  class << self
    def add(lib)
      reader_data_hash = reader_data
      reader = new_reader(reader_data_hash)

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

    private

    def reader_data
      print 'Enter Name and Email: '
      reader_name, reader_email = gets.chomp.strip.split(' ')
      print 'Enter City and Street: '
      reader_city, reader_street = gets.chomp.strip.split(' ')
      print 'Enter House: '
      reader_house = gets.chomp.to_i
      { reader_name:, reader_email:, reader_city:, reader_street:, reader_house: }
    end

    def new_reader(reader_hash)
      return nil if reader_hash[:reader_name].empty? || reader_hash[:reader_email].empty? ||
                    reader_hash[:reader_city].empty? || reader_hash[:reader_street].empty? ||
                    reader_hash[:reader_house].negative?

      Reader.new(name: reader_hash[:reader_name], email: reader_hash[:reader_email], city: reader_hash[:reader_city],
                 street: reader_hash[:reader_street], house: reader_hash[:reader_house])
    end
  end
end
