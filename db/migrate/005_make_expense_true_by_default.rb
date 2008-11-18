class MakeExpenseTrueByDefault < ActiveRecord::Migration
  def self.up
    change_column :items, :expense, :boolean, :default=>true
  end

  def self.down
    change_column :items, :expense, :boolean, :default=>false
  end
end
