class RemoveImageMagik < ActiveRecord::Migration
  def change
  	drop_attached_file :tributes, :image
  	remove_attachment :users, :avatar
  end
end
