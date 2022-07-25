require 'Person'

class Reader < Person
  attr_accessor :email, :city, :street, :house

  def initialize(name, email, city, street, house)
    super name
    @email = email
    @city = city
    @street = street
    @house = house
  end
end

