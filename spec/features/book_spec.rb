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

  it 'displays an error message if an author is selected as well as a new author entered' do
    visit '/books/new'
    fill_in("book[title]", with: "A new book")
    choose("book_genre_fiction")
    select("Test Author 1", from: "book_author_id")
    fill_in("book[author]", with: "A new author")
    click_button("Create Book")
    expect(page).to have_content("New Book Form")
    expect(page).to have_content("Author cannot select an existing author and enter a new author")
  end

  it 'displays an error message if no author selected and no new author entered' do
    visit '/books/new'
    fill_in("book[title]", with: "A new book")
    choose("book_genre_fiction")
    click_button("Create Book")
    expect(page).to have_content("New Book Form")
    expect(page).to have_content("Author must exist")
  end

  it 'creates a new book with an existing author' do
    visit '/books/new'
    fill_in("book[title]", with: "Test Book 4")
    choose("book_genre_non-fiction")
    select("Test Author 2", from: "book_author_id")
    fill_in("book[about]", with: "About test book 4...")
    click_button("Create Book")
    expect(current_path).to eq("/books/4")
    expect(page).to have_content("Test Book 4")
    expect(page).to have_content("Test Author 2")
    expect(page).to have_content("Non-fiction")
    expect(page).to have_content("About test book 4...")
  end

  it 'creates a new book with a new author' do
    visit '/books/new'
    fill_in("book[title]", with: "Test Book 4")
    choose("book_genre_non-fiction")
    fill_in("book[author]", with: "Test Author 3")
    fill_in("book[about]", with: "About test book 4...")
    click_button("Create Book")
    expect(current_path).to eq("/books/4")
    expect(page).to have_content("Test Book 4")
    expect(page).to have_content("Test Author 3")
    expect(page).to have_content("Non-fiction")
    expect(page).to have_content("About test book 4...")
  end

  it 'does not allow for a duplicate book entry' do
    visit '/books/new'
    fill_in("book[title]", with: "test book 3")
    choose("book_genre_non-fiction")
    select("Test Author 1", from: "book_author_id")
    click_button("Create Book")
    expect(page).to have_content("New Book Form")
    expect(page).to have_content("Title has already been taken")
  end

end
