# This migration comes from auto_error (originally 20130128004546)
class CreateAutoErrorAppErrors < ActiveRecord::Migration
  def change
    create_table :auto_error_app_errors do |t|
      t.string :group

      t.string :klass
      t.string :controller
      t.string :action

      t.string :message
      t.text :backtrace
      t.text :data

      t.datetime :resolved_at, default: nil

      t.timestamps
    end
  end
end
