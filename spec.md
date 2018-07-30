# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project - started the app with rails new to ensure it's a Rails app
- [X] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes) - User has_many Books (i.e. users can add many books to their reading list)
- [X] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User) - Book belongs_to Author (i.e. a book belongs to one author)
- [X] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients) - User has_many Books (as books_commented) through Comments (i.e. a user can comment on many different books). Different from the relationship of has_and_belongs_to_many between books and users because that is in regards to books in a user's reading list, and a user may have commented on different books than those which are in their reading list (i.e. user.books may return different results than user.books_commented)
- [X] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity) - Comments have a content attribute (i.e. Comments belong_to Book (as book_commented) and User (as comment_writer) and thus have book_id and user_id, but also have a submittable attribute of content (i.e. what the user said about the book))
- [X] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item) - validations on User, Comment, Book & Author
- [X] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes) - The filter option on Books index page (/books) utilizes Book.added_in_past(timeframe)
- [X] Include signup (how e.g. Devise) - Welcome page links to a signup form (/users/new) which takes user input of name, username, password, and password confirmation and that form submits to users#create, which creates a new user (if no errors) and logs them in.
- [X] Include login (how e.g. Devise) - Welcome page links to a login form (/sessions/new) which takes user input of username and password and that form submits to sessions#create, which logs the user in if their username can be found and then password authenticated.
- [X] Include logout (how e.g. Devise) - When a user is logged in, there is a logout button present in the navbar. The button submits to sessions#delete which clears the session id, sets current user to nil, and then redirects to welcome page.
- [X] Include third party signup/login (how e.g. Devise/OmniAuth) - Using OmniAuth and OmniAuth-Facebook gems to allow for signup/login via FB. There is a link on homepage for signing up/logging in via FB.
- [X] Include nested resource show or index (URL e.g. users/2/recipes) - Comments are a nested resource of Books. You can see all comments about a book at /books/:id/comments - there's a button on the Book's show page which takes you to its comments index page.
- [X] Include nested resource "new" form (URL e.g. recipes/1/ingredients) - Comments are a nested resource of Books. You can add a comment on a book in the form at /books/:id/comments/new - there's a button on the Book's show page which takes you to its new comment form.
- [X] Include form display of validation errors (form URL e.g. /recipes/new) - The books partial (_form.html.erb) which is used in the new and edit views for books, will display at the top of the page any errors on the book, when the form is rendered.

Confirm:
- [X] The application is pretty DRY
- [X] Limited logic in controllers
- [X] Views use helper methods if appropriate
- [X] Views use partials if appropriate
