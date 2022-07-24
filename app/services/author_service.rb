require './entity/entities'
require 'json'

module AuthorService

  @json_name = "../json/data.json"

  @json_new = @json_name + ".new"
  @json_old = @json_name + ".old"

  #add to json
  def AuthorService.add_author?(name, biography)
    begin
      file = File.open("../json/data.json", "r")
      data_hash = JSON.parse(file.read)
      file.close

      data_hash["Authors"] << {name: name, biography: biography}

      File.write(@json_new,JSON.pretty_generate(data_hash))

      File.rename(@json_name, @json_old)
      File.rename(@json_new, @json_name)
      File.delete(@json_old)
    rescue
       return false
    end
    return true
  end

  #delete from json and return the result
  def AuthorService.delete_author?(author)
    begin
      file = File.open("../json/data.json", "r")
      data_hash = JSON.parse(file.read)
      file.close

      data_hash["Authors"].delete_if { |h| h["name"] == author.name && h["biography"] == author.biography }

      File.write(@json_new,JSON.pretty_generate(data_hash))

      File.rename(@json_name, @json_old)
      File.rename(@json_new, @json_name)
      File.delete(@json_old)
    rescue
      return false
    end

    return true
  end

  #retrun all users from json
  def AuthorService.get_all_authors
    authors = []
    File.open("../json/data.json") do |file|
      date_hash = JSON.parse(file.read)

      author_hash = date_hash["Authors"]

      author_hash.each do |elem|
        authors.push(Author.new(elem["name"], elem["biography"]))
      end

      return authors
    end
  end

end