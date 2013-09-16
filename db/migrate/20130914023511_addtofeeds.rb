class Addtofeeds < ActiveRecord::Migration
  def up
  add_column :newsfeeds, :title, :string
    add_column :newsfeeds, :description, :string
    remove_column :newsfeeds, :user_id,:integer

  end

  def down

  end
end
