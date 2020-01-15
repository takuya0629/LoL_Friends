class AddColumnUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :summoner_name, :string
    add_column :users, :group_id, :integer
    add_column :users, :admin, :boolean
  end
end
