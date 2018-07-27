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

  let (:comment) {
    user.comments.create(content: "Great Book!", book_id: book.id, private: false)
  }

  it "is valid when created with content, associated user and book, and private attr set" do
    expect(comment).to be_valid
  end

  it "is not valid without content" do
    new_comm = user.comments.create(book_id: book.id)
    expect(new_comm).to be_invalid
  end

  it "is not valid without an associated book or user" do
    no_book = user.comments.create(content: "Pretty good.")
    no_user = book.comments.create(content: "Eh, alright")
    expect(no_book).to be_invalid
    expect(no_user).to be_invalid
  end

  it "belongs to a user" do
    expect(comment.comment_writer).to eq(user)
  end

  it "belongs to a book" do
    expect(comment.book_commented).to eq(book)
  end


end
