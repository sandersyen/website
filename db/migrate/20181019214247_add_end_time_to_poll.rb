class AddEndTimeToPoll < ActiveRecord::Migration[5.1]
  def change
    add_column :polls, :end_time, :datetime
  end
end
