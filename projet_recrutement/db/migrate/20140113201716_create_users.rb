class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_login
      t.string :user_pass
      t.string :user_mail
      t.integer :user_state
      t.integer :user_status

      t.timestamps
    end
  end
end
