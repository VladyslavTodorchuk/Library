# frozen_string_literal: true

module LibraryService
  class << self
    def save(obj)
      File.write('../storage/data.yml', obj.to_yaml)
    end

    def load
      YAML.load_file('../storage/data.yml', permitted_classes: [Library, Author, Book, Reader, Order, Date], aliases: true)
    end
  end
end
