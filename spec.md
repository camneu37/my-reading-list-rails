# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project - started the app with rails new to ensure it's a Rails app
- [X] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes) - User has_many Books (i.e. users can add many books to their reading list)
- [X] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User) - Book belongs_to Author (i.e. a book belongs to one author)
- [X] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients) - Book has_many Users (as comment_writers) through Comments (i.e. a book can be commented on by many different users)
- [X] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity) - Comments have content and private attributes (i.e. Comments belong_to Book (as book_commented) and User (as comment_writer) and thus have book_id and user_id, but also have submittable attributes of content (i.e. what the user said about the book) and a boolean attribute of private (i.e. true if they don't want other users to see the comment they left on a book))
- [X] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item) - validations on User, Comment, Book & Author
- [ ] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
- [ ] Include signup (how e.g. Devise)
- [ ] Include login (how e.g. Devise)
- [ ] Include logout (how e.g. Devise)
- [ ] Include third party signup/login (how e.g. Devise/OmniAuth)
- [ ] Include nested resource show or index (URL e.g. users/2/recipes)
- [ ] Include nested resource "new" form (URL e.g. recipes/1/ingredients)
- [ ] Include form display of validation errors (form URL e.g. /recipes/new)

Confirm:
- [ ] The application is pretty DRY
- [ ] Limited logic in controllers
- [ ] Views use helper methods if appropriate
- [ ] Views use partials if appropriate
