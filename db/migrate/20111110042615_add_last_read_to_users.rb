class AddLastReadToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.timestamp :last_read_at
    end
  end
end
