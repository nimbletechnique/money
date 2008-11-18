class AddNameToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :name, :string
  end

  def self.down
    remove_column :items, :name
  end
end
