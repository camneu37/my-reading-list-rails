class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.integer :rating
      t.references :rateable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
