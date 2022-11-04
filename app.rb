require_relative './student'
require_relative './teacher'
require_relative './book'
require_relative './rental'

class App
  attr_accessor :books, :people, :rentals

  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def run
    puts 'Welcome to the School Library App!'
    until list_options
      input = gets.chomp
      if input == '7'
        puts 'Have a good Day!'
        break
      end
      option(input)
    end
  end

  def list_all_books
    puts '***BOOKS***'
    puts "Opps! You don't have any books. Try creating one (option 4)." if @books.empty?
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_all_people
    puts '***PEOPLE***'
    puts "Opps! Can't find anyone. Create a person (option 3)." if @people.empty?
    @people.each do |person|
      puts "Name: #{person.name}, Age: #{person.age}"
    end
  end

  def create_person
    puts 'Select one option below'
    puts '1 - Create a teacher'
    puts '2 - Create a student'
    person_option = gets.chomp

    case person_option
    when '1'
      create_teacher
    when '2'
      create_student
    else
      puts 'Invalid option'
    end
  end

  def create_teacher
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp

    @people << Teacher.new(age, specialization, name)
    puts 'Teacher created successfully'
  end

  def create_student
    print 'Name: '
    student_name = gets.chomp
    print 'Age: '
    student_age = gets.chomp
    print 'Enter Classroom: '
    classroom = gets.chomp
    print 'Has parent permission? [Y/N]: '
    student_permission = gets.chomp.downcase == 'y'
    case student_permission
    when 'y'
      student_permission = true
    when 'n'
      student_permission = false
    else
      puts 'Invalid option'
    end

    @people << Student.new(student_age, classroom, student_name, student_permission)
    puts 'Student created successfully'
  end

  def create_book
    puts 'Enter the title of the book'
    title = gets.chomp
    puts 'Enter the author of the book'
    author = gets.chomp

    @books << Book.new(title, author)
    puts "'#{title}' by #{author} has been successfully added to the books list"
  end

  def create_rental
    puts 'Select a book by its ID: '
    @books.each_with_index do |book, index|
      puts "ID: #{index}, Title: #{book.title}, Author: #{book.author}"
    end
    selected_book = gets.chomp.to_i
    puts 'Select a person by ID: '
    @people.each_with_index do |person, index|
      puts "ID:#{index}, Name: #{person.name}, Age: #{person.age}"
    end
    selected_person = gets.chomp.to_i
    puts 'Enter the date of the rental (yyyy-mm-dd): '
    date = gets.chomp.to_s
    @rentals << Rental.new(date, @books[selected_book], @people[selected_person])
    # @rentals << rental
    puts 'Rental created successfully and added to the rentals list'
  end

  def list_all_rentals
    puts 'Select person by ID: '
    @people.each do |person|
      puts "ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
    end
    selected_person = gets.chomp.to_i
    puts 'Rented Books:'
    @rentals.each do |rental|
      next unless rental.person.id == selected_person

      puts "Title: #{rental.book.title}, Author: #{rental.book.author}, Date: #{rental.date}"
    end
  end
end
