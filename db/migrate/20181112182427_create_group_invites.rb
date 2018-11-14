class CreateGroupInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :group_invites do |t|
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true

      t.timestamps
    end

    add_index :group_invites, [:user_id, :group_id], unique: true
  end
end
