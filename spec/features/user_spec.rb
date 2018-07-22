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

  it 'does note allow account creation without password confirmation' do
    visit '/users/new'
    fill_in("user[name]", with: "Test User")
    fill_in("user[username]", with: "test_user")
    fill_in("user[password]", with: "test")
    click_button("Sign Up")
    expect(page).to have_content("Create an Account")
    expect(page).to have_content("Password confirmation can't be blank")
  end

end
