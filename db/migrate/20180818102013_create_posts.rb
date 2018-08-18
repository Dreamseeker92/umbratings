class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.string :author_ip, null: false
      t.float :average_rating, index: true
      t.integer :ratings_count, default: 0
      t.references :author

      t.timestamps
    end
  end
end
