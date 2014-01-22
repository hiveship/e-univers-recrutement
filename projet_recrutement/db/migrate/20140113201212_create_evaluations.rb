class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.integer :eval_mark
      t.string :eval_commentary

      t.timestamps
    end
  end
end
