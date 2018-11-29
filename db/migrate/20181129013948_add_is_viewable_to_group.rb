class AddIsViewableToGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :is_viewable, :boolean
  end
end
