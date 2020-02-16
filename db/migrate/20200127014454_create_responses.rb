class CreateResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :responses do |t|
      t.references :user, foreign_key: true
      t.references :board, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
