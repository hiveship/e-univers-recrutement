class CreateCandidatures < ActiveRecord::Migration
  def change
    create_table :candidatures do |t|
      t.string :pseudo
      t.string :mail
      t.string :motivation
      t.date :submitDate
      t.date :bornDate
      t.string :result
      t.integer :id_session

      t.timestamps
    end
  end
end
