# frozen_string_literal: true

require './entity/reader'

module ReaderService
  class << self
    def add(library)
      reader_data_hash = reader_data
      reader = new_reader(reader_data_hash)

      return '!- Reader, is already exits' if library.readers.find { |r| r.email == reader.email }

      library.readers << reader
      '!- Reader, was added'
    end

    def show(library)
      readers = library.readers
      readers.each do |reader|
        puts reader.to_s
      end
    end

    def delete(library)
      print 'Enter email: '
      reader_email = gets.chomp.strip
      return '!- Reader was deleted' if library.readers.delete_if { |reader| reader.email == reader_email }
      return '!- Reader does not exits' unless library.readers.delete_if { |reader| reader.email == reader_email }

      '!- Can`t delete reader he has order'
    end

    def show_books(library)
      print 'Enter email: '
      reader_email = gets.chomp.strip
      library.orders.select { |order| order.reader.email == reader_email }.each do |order|
        puts order
      end
    end

    def reader(library, top_books, top_count = 1)
      top_books.each do |book, _v|
        orders = library.orders.select { |order| order.book == book }.first(top_count)
        puts book.to_s
        orders.each do |e|
          puts "\t |#{e.reader.name} #{e.reader.email}"
        end
      end
    end

    def most_popular_book(library, top_count = 1)
      readers_hash = Hash.new(0)
      library.orders.each { |order| readers_hash[order.reader] += 1 }
      readers_hash.first top_count
    end

    private

    def reader_data
      print 'Enter Name and Email: '
      reader_name = gets.chomp.strip
      reader_email = gets.chomp.strip
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
