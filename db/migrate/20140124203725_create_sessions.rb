class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :title
      t.date :beginDate
      t.date :endDate
      t.string :state
      t.string :description
      t.integer :id_profil

      t.timestamps
    end
  end
end
