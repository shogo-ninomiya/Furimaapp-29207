class RenameCommnetColumnToItems < ActiveRecord::Migration[6.0]
  def change
    rename_column :items, :commnet, :comment
  end
end
