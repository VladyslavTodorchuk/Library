module LibraryService

  def LibraryService.save(obj)
    File.write("../storage/data.yml", obj.to_yaml)
  end

  def LibraryService.load
    YAML.load_file("../storage/data.yml",permitted_classes: [Library, Author, Book, Reader, Order, Date],aliases: true)
  end

end