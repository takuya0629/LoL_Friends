class CreateJoinGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :join_groups do |t|
      t.references :group, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :group_owner_id nul: false 

      t.timestamps
    end
  end
end
