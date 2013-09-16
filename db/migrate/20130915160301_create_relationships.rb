class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer  :newsfeed_id
      t.integer :user_id

      t.timestamps
    end

    add_index :relationships, :newsfeed_id
    add_index :relationships, :user_id
    add_index :relationships, [:newsfeed_id, :user_id], unique: true
  end

end
