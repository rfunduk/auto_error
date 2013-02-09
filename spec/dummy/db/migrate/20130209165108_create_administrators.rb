class CreateAdministrators < ActiveRecord::Migration
  def change
    create_table :administrators do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.boolean :special, default: false
      t.timestamps
    end
  end
end
