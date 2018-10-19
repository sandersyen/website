class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.text :description
      t.references :category, foreign_key: true
      t.boolean :is_public

      t.timestamps
    end
  end
end
