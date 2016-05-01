class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.text :comment
      t.references :user, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true
      t.integer :grade

      t.timestamps null: false
    end
    add_index :readings, [:user_id, :book_id, :created_at]
  end
end
