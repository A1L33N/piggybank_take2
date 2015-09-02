class CreateChores < ActiveRecord::Migration
  def change
    create_table(:chores) do |t|
      t.column(:description, :string)
      t.column(:pay, :decimal, precision: 10, scale: 2)
      t.column(:kid_id, :integer)
      t.column(:parent_id, :integer)
      t.column(:available, :boolean)
      t.column(:complete, :boolean)

      t.timestamps()
    end
  end
end
