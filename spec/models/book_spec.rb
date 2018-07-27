require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:user) {
    User.create(
      name: "Camille",
      username: "camille_neuner",
      password: "testpassword",
      password_confirmation: "testpassword"
    )
  }

  let(:author) {
    Author.create(name: "Frank")
  }

  let (:book) {
    author.books.create(
      title: "Sticky Fingers",
      about: "Memoir of the creator of Rolling Stone magazine.",
      genre: "Non-fiction"
    )
  }

  it "is not valid without a title" do
    test_book = Book.create(about: "Testingggg")
    expect(test_book).to be_invalid
  end

  it "is valid with a genre of 'Fiction' or 'Non-Fiction'" do
    new_book = author.books.create(title: "A Test Book", genre: "Fiction")
    expect(new_book).to be_valid
    expect(book).to be_valid
  end

  it "is not valid with a genre of anything other than 'Fiction' or 'Non-Fiction'" do
    new_book = author.books.create(title: "A Test Book", genre: "Scary")
    expect(new_book).to be_invalid
  end

  it "has many users" do
    new_user = book.users.create(name: "Will", username: "will_n", password: "testpassword", password_confirmation: "testpassword")
    book.users << user
    expect(book.users.first).to eq(new_user)
    expect(book.users.last).to eq(user)
  end

  it "belongs to many users" do
    new_user = book.users.create(name: "Will", username: "will_n", password: "testpassword", password_confirmation: "testpassword")
    book.users << user
    expect(user.books).to include(book)
    expect(new_user.books).to include(book)
  end

  it "has many comments" do
    comm1 = book.comments.create(content: "Great Book!", user_id: user.id)
    comm2 = book.comments.create(content: "Eh, it was ok.", user_id: user.id)
    expect(book.comments.count).to eq(2)
  end

  it "makes title titlecase before creation" do
    new_book = Book.create(title: "a testing book of words", genre: 'Non-fiction', author_id: author.id)
    expect(new_book.title).to eq("A Testing Book Of Words")
  end

end
