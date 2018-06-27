require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:user) {
    User.create(
      name: "Camille",
      email: "camille@neuner.com",
      password: "testpassword"
    )
  }

  let(:author) {
    Author.create(name: "Frank")
  }

  let (:book) {
    author.books.create(
      title: "Sticky Fingers",
      about: "Memoir of the creator of Rolling Stone magazine."
    )
  }

  it "is not valid without a title" do
    test_book = Book.create(about: "Testingggg")
    expect(test_book).to be_invalid
  end

  it "has many users" do
    new_user = book.users.create(name: "Will", email: "will@neuner.com", password: "testpassword")
    book.users << user
    expect(book.users.first).to eq(new_user)
    expect(book.users.last).to eq(user)
  end

  it "belongs to many users" do
    new_user = book.users.create(name: "Will", email: "will@neuner.com", password: "testpassword")
    book.users << user
    expect(user.books).to include(book)
    expect(new_user.books).to include(book)
  end

end
