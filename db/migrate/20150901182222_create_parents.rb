class CreateParents < ActiveRecord::Migration
  def change
    create_table(:parents) do |t|
      t.column(:name, :string)
      t.column(:bank_name, :string)

      t.timestamps()
    end
  end
end
