class ChangeMessageColumnToText < ActiveRecord::Migration
  def up
    change_column :auto_error_app_errors, :message, :text
  end

  def down
    change_column :auto_error_app_errors, :message, :string
  end
end
