class AddRoleToGroupMembership < ActiveRecord::Migration[5.2]
  def change
    add_column :group_memberships, :role, :string
  end
end
