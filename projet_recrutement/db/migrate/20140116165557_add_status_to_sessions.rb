class AddStatusToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :sess_status, :integer
  end
end
