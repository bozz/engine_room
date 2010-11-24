class CreateFields < ActiveRecord::Migration
  def self.up
    create_table(:fields) do |t|
      t.integer :section_id,   :null => false
      t.string  :column,       :null => false
      t.string  :field_type,   :null => false
      t.string  :display_type, :null => false
      t.text    :options
      t.text    :help
      t.integer :sort_order
      t.timestamps
    end
  end

  def self.down
    drop_table :fields
  end
end
