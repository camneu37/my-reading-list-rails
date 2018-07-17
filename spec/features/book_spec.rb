require_relative "../rails_helper.rb"

describe 'Feature Test: Book Library (Books Index Page)', type: :feature do

  before :each do
    @author_one = Author.create(name: "Test Author 1")
    @author_two = Author.create(name: "Test Author 2")
    @book_one = @author_one.books.create(title: "Test Book 1", about: "A new test book", genre: "Fiction")
    @book_two = @author_one.books.create(title: "Test Book 2", about: "A new test book", genre: "Non-fiction")
    @book_three = @author_two.books.create(title: "Test Book 3", about: "A new test book", genre: "Fiction")
  end

  it 'has an index page for the book library' do
    visit '/books'
    expect(current_path).to eq('/books')
    expect(page).to have_content("Book Library")
  end

  it 'has an index page listing all books' do
    visit '/books'
    expect(page).to have_content(@book_one.title)
    expect(page).to have_content(@book_two.title)
    expect(page).to have_content(@book_three.title)
  end

  it 'has an index page listing the author for each book' do
    visit '/books'
    expect(page).to have_content(@author_one.name)
    expect(page).to have_content(@author_two.name)
  end

  it 'links from the books index page to the books show pages' do
    visit '/books'
    click_link(@book_one.title)
    expect(current_path).to eq('/books/1')
    expect(page).to have_content(@book_one.title)
    expect(page).to have_content(@book_one.genre)
    expect(page).to have_content(@book_one.about)
  end

  it 'links from the books index page to the new book form' do
    visit '/books'
    click_link("Add a Book")
    expect(current_path).to eq('/books/new')
    expect(page).to have_content("New Book Form")
  end

end

describe 'Feature Test: Creating a New Book', type: :feature do

  before :each do
    @author_one = Author.create(name: "Test Author 1")
    @author_two = Author.create(name: "Test Author 2")
    @book_one = @author_one.books.create(title: "Test Book 1", about: "A new test book", genre: "Fiction")
    @book_two = @author_one.books.create(title: "Test Book 2", about: "A new test book", genre: "Non-fiction")
    @book_three = @author_two.books.create(title: "Test Book 3", about: "A new test book", genre: "Fiction")
  end

  it 'has a new book form' do
    visit '/books/new'
    expect(current_path).to eq('/books/new')
    expect(page).to have_content("New Book Form")
    expect(page).to have_content("Title")
    expect(page).to have_content("Genre")
    expect(page).to have_content("Author")
    expect(page).to have_content("About")
    expect(page).to have_button("Create Book")
  end

  it 'displays an error message if submit without a title' do
    visit '/books/new'
    choose("book_genre_fiction")
    fill_in("book[author]", with: "A new author")
    fill_in("book[about]", with: "About a new book...")
    click_button("Create Book")
    expect(page).to have_content("New Book Form")
    expect(page).to have_content("Title can't be blank")
  end

  it 'displays an error message if no genre selected' do
    visit '/books/new'
    fill_in("book[title]", with: "A new book")
    fill_in("book[author]", with: "A new author")
    fill_in("book[about]", with: "About a new book...")
    click_button("Create Book")
    expect(page).to have_content("New Book Form")
    expect(page).to have_content("Genre is not included in the list")
  end

end