class CreateChatrooms < ActiveRecord::Migration[5.2]
  def change
    create_table :chatrooms do |t|
      t.references :user, foreign_key: true
      t.string :title, nul: false
      t.string :content
    end
  end
end
