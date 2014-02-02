class CreateCandidatures < ActiveRecord::Migration
  def change
    create_table :candidatures do |t|
      t.string :pseudo
      t.string :mail
      t.string :motivation
      t.date :submitDate
      t.date :bornDate
      t.string :result
      t.belongs_to :session

      t.timestamps
    end
  end
end
