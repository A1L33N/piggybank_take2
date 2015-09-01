class CreateTransactions < ActiveRecord::Migration
  def change
    create_table(:transactions) do |t|
      t.column(:amount, :decimal, precision: 10, scale: 2)
      t.column(:type, :string)
      t.column(:description, :string)
      t.column(:date, :date)
      t.column(:child_id, :integer)

      t.timestamps()
    end
  end
end
