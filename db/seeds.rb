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

hunt = Author.find(1)
fitz = Author.find(2)

def make_books
