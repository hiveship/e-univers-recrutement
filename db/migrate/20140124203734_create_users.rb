class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :pass
      t.string :mail
      t.string :state
      t.string :status

      t.timestamps
    end
  end
end
