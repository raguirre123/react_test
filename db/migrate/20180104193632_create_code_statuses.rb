class CreateCodeStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :code_statuses do |t|
      t.string :name
      t.integer :code

      t.timestamps
    end
  end
end
