class AddPrivacyColumnToGroupsTable < ActiveRecord::Migration
  def change
    add_column :groups, :privacy, :integer
  end
end
