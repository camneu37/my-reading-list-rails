require_relative "../rails_helper.rb"

describe 'Feature Test: View Books in Library', type: :feature do

  before :each do
    @author_one = Author.create(name: "Test Author 1")
    @author_two = Author.create(name: "Test Author 2")
    @book_one = @author_one.books.create(title: "Test Book 1", about: "A new test book", genre: "Fiction")
    @book_two = @author_one.books.create(title: "Test Book 2", about: "A new test book", genre: "Non-fiction")
    @book_three = @author_two.books.create(title: "Test Book 3", about: "A new test book", genre: "Fiction")
  end

  it 'has an index page listing all books' do
    visit '/books'
    expect(current_path).to eq('/books')
    expect(page).to have_content(@book_one.title)
    expect(page).to have_content(@book_two.title)
    expect(page).to have_content(@book_three.title)
  end

  it 'has an index page listing the author for each book' do
    visit '/books'
    expect(current_path).to eq('/books')
    expect(page).to have_content(@author_one.name)
    expect(page).to have_content(@author_two.name)
  end



end
