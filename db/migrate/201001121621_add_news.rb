class AddNews < ActiveRecord::Migration
  def self.up
    add_column :blogs, :news, :boolean, :default => false
  end

  def self.down
    remove_column :blogs, :news
  end
end

