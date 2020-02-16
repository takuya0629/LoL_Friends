class AddUniqueToSummonerId < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :summoner_name, unique: true
  end
end
