class ChangeImageurlNotNull < ActiveRecord::Migration[5.1]
  def change
    change_column_null :images, :imageurl, false
  end
end
