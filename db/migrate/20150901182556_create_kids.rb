class CreateKids < ActiveRecord::Migration
  def change
    create_table(:kids) do |t|
      t.column(:name, :string)
      t.column(:account_name, :string)
      t.column(:beginning_balance, :decimal, precision: 10, scale: 2)
      t.column(:goal, :decimal, precision: 10, scale: 2)
      t.column(:parent_id, :integer)

      t.timestamps()

    end
  end
end
