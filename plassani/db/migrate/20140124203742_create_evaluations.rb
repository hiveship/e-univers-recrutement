class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.integer :mark
      t.string :commentary
      t.integer :id_candidature
      t.integer :id_user

      t.timestamps
    end
  end
end
