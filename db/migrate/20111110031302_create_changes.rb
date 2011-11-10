class CreateChanges < ActiveRecord::Migration
  def change
    create_table :changes do |t|
      t.string :link, :null => false
      t.string :title, :null => false

      t.timestamps
    end
  end
end
