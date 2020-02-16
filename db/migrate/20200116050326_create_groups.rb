class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name, nul: false
      t.text :introduction
      t.integer :owner_id, nul: false
      t.boolean :approval_system, default: false
      t.timestamps
    end
  end
end
