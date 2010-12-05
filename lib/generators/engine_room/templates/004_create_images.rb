class CreateImages < ActiveRecord::Migration
  def self.up
    create_table(:images) do |t|
      # todo: add foreign keys to belongs_to model

      t.string   :title
      t.text     :description
      t.string   :image_file_name     # paperclip property
      t.string   :image_content_type  # paperclip property
      t.integer  :image_file_size     # paperclip property
      t.datetime :image_updated_at    # paperclip property
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
