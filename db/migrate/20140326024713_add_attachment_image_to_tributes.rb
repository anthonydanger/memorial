class AddAttachmentImageToTributes < ActiveRecord::Migration
  def self.up
    change_table :tributes do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :tributes, :image
  end
end
