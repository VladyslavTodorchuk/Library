
class Reader
  attr_accessor :name ,:email, :city, :street, :house

  def initialize(name, email, city, street, house)
    @name = name
    @email = email
    @city = city
    @street = street
    @house = house
  end

  def to_s
    "Name: #{@name} Email: #{@email} City: #{@city} Street: #{@street} House: #{@house}"
  end
end

