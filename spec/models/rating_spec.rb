require 'rails_helper'

RSpec.describe Rating, type: :model do

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

    it 'is not valid without a rating score entered' do
      rating = Rating.create
      expect(rating).to be_invalid
    end

    it 'can be added to a book' do
      rating = book.ratings.create(rating: 5)
      expect(rating).to be_valid
      expect(book.ratings).to include(rating)
    end

    it 'can be added to an author' do
      rating = author.ratings.create(rating: 5)
      expect(rating).to be_valid
      expect(author.ratings).to include(rating)
    end

    it 'must be between 1 and 5' do
      rating_one = author.ratings.create(rating: 7)
      rating_two = book.ratings.create(rating: 4)
      expect(rating_one).to be_invalid
      expect(rating_two).to be_valid
    end




end
