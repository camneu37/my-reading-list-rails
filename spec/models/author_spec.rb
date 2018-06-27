require 'rails_helper'

RSpec.describe Author, type: :model do

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

  it "is not valid without a name" do
    a = Author.create
    expect(a).to be_invalid
  end

  it "has many books" do
    new_book = author.books.create(title: "Test Book", genre: "Fiction")
    expect(author.books).to include(book)
    expect(author.books).to include(new_book)
  end

end
