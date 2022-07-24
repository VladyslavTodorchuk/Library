require '../app/services/author_service'


class Library

  attr_accessor :authors, :books, :readers, :orders

  def initialize

  end

  def find_top_reader

  end

  def find_most_popular_book

  end

  def get_number_of_readers_of_most_popular_book

  end

  def self.print_instruction

    puts "(Write command by typing <entity, command>) \n Chose action:"
    puts "\t\nAuthor\n1) Add \n2) Show \n3) Show Books \n4) Delete"

    puts "\t\nBook\n1) Add \n2) Show \n3) Show most popular books \n4) Delete"

    puts "\t\nReader\n1) Add \n2) Show \n3) Show Reader's books \n4) Delete"

    puts "\t\nOrder\n1) Add \n2) Show \n3) Delete Order"

    puts "\nWrite 'Exit' to finish"

  end
end
