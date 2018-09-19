class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content, null:false
      t.integer :author_id, null:false
      t.references :post, foreign_key: true, null:false
      t.integer :parent_comment_id

      t.timestamps
    end
    add_index :comments, :parent_comment_id
    add_index :comments, :author_id
  end
end
