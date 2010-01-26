class AddNewsOptionsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :can_send_news, :boolean, :default => false
  end

  def self.down
    remove_column :users, :can_send_news
  end
end

