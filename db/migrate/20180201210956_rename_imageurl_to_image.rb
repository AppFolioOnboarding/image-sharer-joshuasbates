class RenameImageurlToImage < ActiveRecord::Migration[5.1]
  def change
    rename_table :imageurls, :images
  end
end
