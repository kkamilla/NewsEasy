class CreateNewsfeeds < ActiveRecord::Migration
  def change
    create_table :newsfeeds do |t|
      t.string :link
      t.integer :user_id

      t.timestamps
    end
  end
end
