class AddColomnToJoinGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :join_groups, :approve, :boolean, default: false
  end
end
