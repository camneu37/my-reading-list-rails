require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {
    User.create(
      name: "Camille",
      username: "camille1",
      password: "testpassword",
      password_confirmation: "testpassword"
    )
  }

  it "is not valid without a name" do
    test_user = User.create(username: "testing", password: "test")
    expect(test_user).to be_invalid
  end

  it "is not valid without a username" do
    test_user = User.create(name: "Tester", password: "test")
    expect(test_user).to be_invalid
  end

  it "is not valid without a password" do
    test_user = User.create(name: "Tester", username: "tester")
    expect(test_user).to be_invalid
  end

  it "must have a unique username" do
    test_user = User.create(name: "Camille", username: "camille1", password: "test")
  end

  it "has many books" do
    first_b = user.books.create(title: "Test Book 1")
    second_b = user.books.create(title: "Test Book 2")
    expect(user.books.first).to eq(first_b)
    expect(user.books.last).to eq(second_b)
  end

  it "belongs to many books" do
    a = Author.create(name: "Tester")
    first_b = user.books.create(title: "Test Book 1", author_id: a.id, genre: "Fiction")
    second_b = user.books.create(title: "Test Book 2", author_id: a.id, genre: "Non-fiction")
    expect(first_b.users).to include(user)
    expect(second_b.users).to include(user)
  end

  it "has many comments" do
    a = Author.create(name: "Tester")
    first_b = user.books.create(title: "Test Book 1", author_id: a.id, genre: "Fiction")
    second_b = user.books.create(title: "Test Book 2", author_id: a.id, genre: "Non-fiction")
    comm1 = first_b.comments.create(content: "Great Book!", user_id: user.id)
    comm2 = second_b.comments.create(content: "Eh, it was ok.", user_id: user.id)
    expect(user.comments.count).to eq(2)
  end


end
