class CreateCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :codes do |t|
      t.string :name
      t.float :value
      t.integer :code_status_id
      t.integer :user_id

      t.timestamps
    end
  end
end
