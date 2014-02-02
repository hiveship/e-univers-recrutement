class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.integer :mark
      t.string :commentary
      t.belongs_to :candidature
      t.belongs_to :user

      t.timestamps
    end
  end
end
