class RenameNickbameColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :nickbame, :nickname
  end
end
