class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :last_name
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :city
      t.string :country
      t.string :uuid
      t.string :phone
      t.string :document
      t.datetime :last_login

      t.timestamps
    end
  end
end
