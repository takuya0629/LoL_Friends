class AddColumnUsers3 < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :favorite_summoner, :string
  end
end
