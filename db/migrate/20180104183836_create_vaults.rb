class CreateVaults < ActiveRecord::Migration[5.1]
  def change
    create_table :vaults do |t|
      t.integer :user_id
      t.float :value
      t.string :uuid

      t.timestamps
    end
  end
end
