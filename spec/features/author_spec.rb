require_relative "../rails_helper.rb"

describe 'Feature Test: Authors', type: :feature do

  before :each do
    @author_one = Author.create(name: "Test Author 1")
    @author_two = Author.create(name: "Test Author 2")
    @book_one = @author_one.books.create(title: "Test Book 1", about: "A new test book", genre: "Fiction")
    @book_two = @author_one.books.create(title: "Test Book 2", about: "A new test book", genre: "Non-fiction")
    @book_three = @author_two.books.create(title: "Test Book 3", about: "A new test book", genre: "Fiction")
  end

  it 'has an authors index page' do
    visit '/authors'
    expect(current_path).to eq("/authors")
    expect(page).to have_content("List of Authors")
    expect(page).to have_content("Test Author 1")
    expect(page).to have_content("Test Author 2")
  end

  it 'has an index page that links to authors show pages' do
    visit '/authors'
    expect(page).to have_link("Test Author 1")
    click_link("Test Author 1")
    expect(current_path).to eq("/authors/1")
  end

  it 'has author show pages with authors books listed' do
    visit '/authors/1'
    expect(current_path).to eq("/authors/1")
    expect(page).to have_content("Test Author 1")
    expect(page).to have_content("Test Book 1")
    expect(page).to have_content("Test Book 2")
  end

  it 'links to book show pages from authors show page' do
    visit '/authors/1'
    expect(page).to have_link("Test Book 1")
    click_link("Test Book 1")
    expect(current_path).to eq("/books/1")
    expect(page).to have_content("Test Book 1")
    expect(page).to have_content("Test Author 1")
    expect(page).to have_content("Fiction")
  end



end
