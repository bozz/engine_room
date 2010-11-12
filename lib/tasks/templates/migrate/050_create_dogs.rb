class CreateDogs < ActiveRecord::Migration
  def self.up
    create_table :dogs do |t|
      t.string :name, :null => false
      t.string :color, :null => true
      t.text :description, :null => true
      t.integer :fleas, :null => true
      t.timestamps
    end

    add_index :dogs, :name
  end

  def self.down
    drop_table :dogs
  end
end

