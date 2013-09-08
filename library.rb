#Time.now + 14*24*3600 due date is two weeks from now in seconds
class Book
  attr_reader :title, :author, :description
  attr_accessor :state, :users, :due_date
  def initialize(title, author, description)
    @title=title
    @author=author
    @description=description
    @users={}
    @state = "this book has not been added to the library"
    @due_date = nil
  end

  def user
    return "#{@users.last.first_name}, {@users.last.first_name} currently has this book"
  end

  def user_log
    @users.each do |user|
      return "#{user.first_name}, #{user.last_name} checked this book out on #{@due_date}"
    end
  end

  def check_out(user, library)
    if library.is_a?(Library) == true
     library.check_out(self, user)
    else
      "library error"
    end
  end

  def check_in(user, library)
    if library.is_a?(Library) == true
     library.check_out(self, user)
    else
      "library error"
    end
  end

  def is_due
    if Time.now > @due_date
      @state = "over due"
      "this book is over due! it was due on #{@due_date.asctime}"
    else
      "this book is due on #{@due_date.asctime}"
    end
  end
end

class User
  attr_reader :first_name, :last_name
  attr_accessor :books

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name= last_name
    @books = []
  end

  def books_log
    return @books
  end
end

class Library
  attr_reader :checked_in, :checked_out, :over_due
  def initialize()
    @checked_in = []
    @checked_out=[]
    @over_due=[]
    @today 
  end

  def add(book)
    if book.is_a?(Book) == true
      @checked_in.push(book)
      book.state = "checked in"
    else
      "not a book"
    end
  end

  def check_log
    @checked_out.each do |book|
      string = "#{book.users.last.first_name} #{book.users.last.first_name} has checked out #{book.title} and it is due back on #{book.due_date}"
      return string
    end
  end

  def check_out(book, user)
    case book.state
      when "checked in"
        # if (user.)#overdue condition
        @checked_in.delete_if{|a| a==book}
        book.state = "checked out"
        today= Time.now
        book.due_date = today + 604800
        @checked_out.push(book)
        book.users[:today] = user 
        user.books.push(book)
        return"you have checked out #{book.title}! it is due back on #{(book.due_date.asctime)}" 
      when "checked out" 
        return "#{book.title} is currently checked out. It will be returned to the library on #{(book.due_date.asctime)}" 
      when "over due"
        return "{book.title} is over due!" 
      else
        return "That book is not in this library."
    end
  end

  def check_in(book, user)
    case book.state
      when "checked out" || "over_due"
        @checked_out.delete_if{|a| a==book}
        book.state = "checked in"
        @checked_in.push(book)
        book.users.user.books.delete_if{|a| a==("#{user.first_name} #{user.last_name}")}
        user.books.delete_if{|a| a==(book.title)}
        book.due_date = nil
        return"you have checked out #{book.title}! it is due back on #{(book.due_date.asctime)}" 
      when "checked in" 
        return "#{book.title} is currently checked in. It will be returned to the library on #{(book.due_date.asctime)}" 
      else
        return "That book is not in this library."
    end
  end
end


library = Library.new
bonnie = User.new("Bonnie", "Mattson")
john = User.new("John", "Huntington")
book1 = Book.new("Matilda", "Dahl", "Smart girl hates parents")
book2 = Book.new("I, Robot", "Asimov", "Robot Emotions")
book3 = Book.new("Master and Commander", "O'Brian", "Tall Ships and cannons")
book4 =Book.new("Bleak House", "Dickens", "Melodrama")
library.add(book1)
library.add(book2)
library.add(book3)
library.add(book4)
puts "I ran"