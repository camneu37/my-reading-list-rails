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
    expect(page).to have_content("Create an account")
  end


end
