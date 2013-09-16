class Modifyfeeds < ActiveRecord::Migration
  def up
    remove_column :newsfeeds, :title, :string
    remove_column :newsfeeds, :description, :string
    remove_column :newsfeeds, :link, :string
    add_column  :newsfeeds, :newsprovider,:string

  end

  def down
  end
end
