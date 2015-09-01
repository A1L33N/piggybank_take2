class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :transactions, :child_id, :kid_id
  end
end
