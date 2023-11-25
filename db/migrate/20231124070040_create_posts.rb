class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.integer :creater_id, null: false
      t.text :body, null: false


      t.timestamps
    end

    add_index :posts, :creater_id

  end
end
