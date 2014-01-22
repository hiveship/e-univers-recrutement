class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :sess_title
      t.date :sess_beginDate
      t.date :sess_endDate
      t.integer :sess_state
      t.string :sess_description

      t.timestamps
    end
  end
end
