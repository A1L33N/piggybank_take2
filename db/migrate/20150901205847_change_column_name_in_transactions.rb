class ChangeColumnNameInTransactions < ActiveRecord::Migration
  def change
    rename_column :transactions, :category, :transaction_type
  end
end
