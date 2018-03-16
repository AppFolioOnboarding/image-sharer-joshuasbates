class ChangeTagListNotEmpty < ActiveRecord::Migration[5.1]
  def change
    Image.reset_column_information
    Image.all.each do |image|
      image.update_attributes!(tag_list: '<unset>') if image.tag_list.empty?
    end
  end
end
