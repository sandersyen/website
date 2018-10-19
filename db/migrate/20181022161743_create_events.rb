class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.text :location
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
