class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :group_name, nul: false
      t.text :introduction
      t.integer :group_owner_id, nul: false
      t.timestamps
    end
  end
end
