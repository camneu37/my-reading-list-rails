require 'rails_helper'

Rspec.describe User, type: :model do
  let(:user) {
    User.create(
      name: "Camille"
      email: "camille@neuner.com"
      password: "testpassword"
    )
  }

  it "is not valid without a name" do
    test_user = User.create(email: "test@test.com", password: "test")
    expect(test_user).to be_invalid
  end

  it "is not valid without an email" do
    test_user = User.create(name: "Tester", password: "test")
    expect(test_user).to be_invalid
  end

  it "is not valid without a password" do
    test_user = User.create(name: "Tester", email: "test@test.com")
    expect(test_user).to be_invalid
  end




end
