class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :content
      t.boolean :private, default: true
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
  end
end
