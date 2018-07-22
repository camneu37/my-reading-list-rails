require_relative "../rails_helper.rb"

describe 'Feature Test: User Sign Up', type: :feature do
  it 'presents user with the option to create an account' do
    visit '/'
    expect(page).to have_content("Welcome to My Reading List!")
    expect(page).to have_link("Sign Up")
    expect(page).to have_link("Log In")
  end

  it 'links to the user sign up page' do
    visit '/'
    click_link("Sign Up")
    expect(current_path).to eq("/users/new")
    expect(page).to have_content("Create an Account")
  end

  it 'does not allow account creation without users name' do
    visit '/users/new'
    fill_in("user[username]", with: "test_user")
    fill_in("user[password]", with: "test")
    fill_in("user[password_confirmation]", with: "test")
    click_button("Sign Up")
    expect(page).to have_content("Create an Account")
    expect(page).to have_content("Name can't be blank")
  end

  it 'does not allow account creation without users username' do
    visit '/users/new'
    fill_in("user[name]", with: "Test User")
    fill_in("user[password]", with: "test")
    fill_in("user[password_confirmation]", with: "test")
    click_button("Sign Up")
    expect(page).to have_content("Create an Account")
    expect(page).to have_content("Username can't be blank")
  end

  it 'does not allow account creation without users password' do
    visit '/users/new'
    fill_in("user[name]", with: "Test User")
    fill_in("user[username]", with: "test_user")
    click_button("Sign Up")
    expect(page).to have_content("Create an Account")
    expect(page).to have_content("Password can't be blank")
  end

  it 'does not allow account creation without password confirmation' do
    visit '/users/new'
    fill_in("user[name]", with: "Test User")
    fill_in("user[username]", with: "test_user")
    fill_in("user[password]", with: "test")
    click_button("Sign Up")
    expect(page).to have_content("Create an Account")
    expect(page).to have_content("Password confirmation can't be blank")
  end

  it 'does not allow for user creation if password confirmation doesnt match password' do
    visit '/users/new'
    fill_in("user[name]", with: "Test User")
    fill_in("user[username]", with: "test_user")
    fill_in("user[password]", with: "test")
    fill_in("user[password_confirmation]", with: "tester")
    click_button("Sign Up")
    expect(page).to have_content("Create an Account")
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  it 'allows for successful creation of a new user' do
    visit '/users/new'
    fill_in("user[name]", with: "Test User")
    fill_in("user[username]", with: "test_user")
    fill_in("user[password]", with: "test")
    fill_in("user[password_confirmation]", with: "test")
    click_button("Sign Up")
    expect(current_path).to eq("/users/1")
    expect(page).to have_content("Test User's Reading List")
  end

end

describe 'Feature Test: User Login', type: :feature do

  it 'takes user to log in page from home page' do
    visit '/'
    click_link("Log In")
    expect(current_path).to eq("/sessions/new")
    expect(page).to have_content("Username")
    expect(page).to have_content("Password")
    expect(page).to have_button("Log In")
  end

end

describe 'Feature Test: Users Homepage', type: :feature do

  before :each do
    @author_one = Author.create(name: "Test Author 1")
    @author_two = Author.create(name: "Test Author 2")
    @book_one = @author_one.books.create(title: "Test Book 1", about: "A new test book", genre: "Fiction")
    @book_two = @author_one.books.create(title: "Test Book 2", about: "A new test book", genre: "Non-fiction")
    @book_three = @author_two.books.create(title: "Test Book 3", about: "A new test book", genre: "Fiction")
    @user = User.create(name: "Test User", username: "test_user", password: "test", password_confirmation: "test")
    @user.add_book_to_reading_list(@book_one)
    @user.add_book_to_reading_list(@book_three)
  end


end
