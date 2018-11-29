class AddIsViewableToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :is_viewable, :boolean
  end
end
