class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :notif_type
      t.references :user, foreign_key: true
      t.integer :actor_id
      t.string :actor_type
      t.integer :target_id
      t.string :target_type
      t.boolean :is_read

      t.timestamps
    end

    add_index :notifications, [:notif_type, :user_id, :actor_id, :actor_type, :target_id, :target_type], :name => 'notifications_index', :unique => true
  end
end
