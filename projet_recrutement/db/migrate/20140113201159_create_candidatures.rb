class CreateCandidatures < ActiveRecord::Migration
  def change
    create_table :candidatures do |t|
      t.string :candidature_pseudo
      t.string :candidature_mail
      t.string :candidature_motivation
      t.date :candidature_date
      t.date :candidature_bornDate
      t.boolean :candidature_result

      t.timestamps
    end
  end
end
