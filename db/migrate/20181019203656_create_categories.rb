class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end

    Category.create(name: 'Technology')
    Category.create(name: 'Business')
    Category.create(name: 'Games')
  end
end
