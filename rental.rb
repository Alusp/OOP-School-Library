class Rental
  attr_accessor :date, :person, :book

  def initialize(date, book, person)
    puts date
    puts book
    puts person
    @date = date
    @book = book
    book.rentals << self
    @person = person
    person.rentals << self
  end
end
