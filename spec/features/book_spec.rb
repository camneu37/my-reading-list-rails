require_relative "../rails_helper.rb"

describe 'Feature Test: Books', type: :feature do

  before :each do
    @author = Author.create(name: "Test Author")
    @book_one = @author.books.create(title: "Test Book 1", about: "A new test book", genre: "Fiction")
    @book_two = @author.books.create(title: "Test Book 2", about: "A new test book", genre: "Non-fiction")
    @book_three = @author.books.create(title: "Test Book 3", about: "A new test book", genre: "Fiction")
  end

  it 'has an index page listing all books' do
    visit '/books'
    expect(current_path).to eq('/books')
    expect(page).to have_content(@author.name)
    expect(page).to have_content(@book_one.title)
    expect(page).to have_content(@book_two.title)
    expect(page).to have_content(@book_three.title)
  end



end
