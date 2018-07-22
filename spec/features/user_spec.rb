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

  before :each do
    @user = User.create(name: "Test User", username: "test user", password: "test", password_confirmation: "test")
  end

  it 'takes user to log in page from home page' do
    visit '/'
    click_link("Log In")
    expect(current_path).to eq("/sessions/new")
    expect(page).to have_content("Username")
    expect(page).to have_content("Password")
    expect(page).to have_button("Log In")
  end

  it 'does not allow a user to log in without username' do
    visit '/sessions/new'
    fill_in("password", with: "test")
    click_button("Log In")
    expect(page).to have_content("Must fill in username and password fields")
  end

  it 'does not allow a user to log in without password' do
    visit '/sessions/new'
    fill_in("username", with: "test user")
    click_button("Log In")
    expect(page).to have_content("Must fill in username and password fields")
  end

  it 'redirects to users homepage if login successful' do
    visit '/sessions/new'
    fill_in("username", with: "test user")
    fill_in("password", with: "test")
    click_button("Log In")
    expect(current_path).to eq("/users/#{@user.id}")
    expect(page).to have_content("#{@user.name}'s Reading List")
  end

  it 'prompts user to try again or create account if user info doesnt exist' do
    visit '/sessions/new'
    fill_in("username", with: "cam")
    fill_in("password", with: "cam")
    click_button("Log In")
    expect(page).to have_content("We couldn't find an account with that username, please try again or create a new account.")
  end

  it 'prompts user to enter correct password if authentication fails' do
    visit '/sessions/new'
    fill_in("username", with: "test user")
    fill_in("password", with: "cam")
    click_button("Log In")
    expect(page).to have_content("The password you entered was incorrect. Please try again.")
  end

  it 'does not allow user to see login page if logged in' do
    visit '/sessions/new'
    fill_in("username", with: "test user")
    fill_in("password", with: "test")
    click_button("Log In")
    visit '/sessions/new'
    expect(current_path).to eq("/users/1")
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
