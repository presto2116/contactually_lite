class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :first_name
      t.string :last_name
      t.string :email_address
      t.string :phone_number
      t.string :company_name

      t.timestamps null: false
    end
  end
end