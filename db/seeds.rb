# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

DATA = {
  user_keys: ["name", "email", "password"],
  users: [
    ["Camille", "camille@neuner.com", "camille"],
    ["Will", "will@neuner.com", "will"],
    ["Carole", "carole@neuner.com", "carole"],
    ["Tony", "tony@neuner.com", "tony"]
  ],
  author_keys: ["name"],
  authors: [
    ["Hunter S. Thompson"],
    ["F. Scott Fitzgerald"]
  ]
}

def main
  make_users
  make_authors
end

def make_users
  DATA[:users].each do |u|
    new_u = User.new
    u.each_with_index do |attribute, i|
      new_u.send(DATA[:user_keys][i]+"=", attribute)
    end
    new_u.save
  end
end

def make_authors
  DATA[:authors].each do |a|
    new_a = Author.new
    a.each_with_index do |attribute, i|
      new_a.send(DATA[:author_keys][i]+"=", attribute)
    end
    new_a.save
  end
end

main

cam = User.find(1)
will = User.find(2)
carole = User.find(3)
tony = User.find(4)

hunt = Author.find(1)
fitz = Author.find(2)

fear = hunt.books.create(title: "Fear and Loathing in Las Vegas", about: "A drug fueled trip through the desert", genre: "Fiction")
rum = hunt.books.create(title: "The Rum Diaries", about: "An alcoholic ex-pat journalist in Puerto Rico", genre: "Non-fiction")
gatz = fitz.books.create(title: "The Great Gatsby", about: "Rich man tries to win back old love by throwing lavish parties", genre: "Fiction")

cam.add_book_to_reading_list(fear)
cam.add_book_to_reading_list(gatz)
will.add_book_to_reading_list(rum)
tony.add_book_to_reading_list(fear)
tony.add_book_to_reading_list(rum)
carole.add_book_to_reading_list(gatz)

cam.comments.create(content: "Great book!", book_id: fear.id, private: true)
cam.comments.create(content: "Loved it!", book_id: gatz.id, private: false)
will.comments.create(content: "Awesome book.", book_id: fear.id, private: false)
will.comments.create(content: "It was ok.", book_id: gatz.id, private: true)
