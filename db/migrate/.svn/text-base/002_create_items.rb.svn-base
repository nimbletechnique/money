class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.column :expense, :boolean, :default=>true
      t.column :amount, :float
      t.column :memo, :string
      t.column :category_id, :integer
      t.column :user_id, :integer, :null=>false
      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
