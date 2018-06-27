require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:user) {
    User.create(
      name: "Camille",
      email: "camille@neuner.com",
      password: "testpassword"
    )
  }

  let (:book) {
    user.books.create(
      title: "Sticky Fingers"
      about: "Memoir of the creator of Rolling Stone magazine."
    )
  }

  it "is not valid without a title" do
    test_book = Book.create(about: "Testingggg")
    expect(test_book).to be_invalid
  end

  it "belongs to and has many users" do
    new_user = book.users.create(name: "Will", email: "will@neuner.com", password: "testpassword")
    expect(book.users.first).to eq(user)
    expect(book.users.last).to eq(new_user)
  end
