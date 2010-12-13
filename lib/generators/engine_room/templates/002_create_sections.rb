class CreateSections < ActiveRecord::Migration
  def self.up
    create_table(:sections) do |t|
      t.string  :name, :null => false
      t.string  :model_name, :null => false
      t.string  :view_type
      t.string  :condition
      t.integer :sort_order
      t.timestamps
    end
  end

  def self.down
    drop_table :sections
  end
end
