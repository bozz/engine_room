class Image < ActiveRecord::Base
  # TODO: adjust style dimensions...
  has_attached_file :image, :styles => { :thumb => "50x50", :full => "50x400" }
end
