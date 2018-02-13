class CreateImageurls < ActiveRecord::Migration[5.1]
  def change
    create_table :imageurls do |t|
      t.string :imageurl, null: false

      t.timestamps
    end
  end
end
