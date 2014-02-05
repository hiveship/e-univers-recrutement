class CreateProfils < ActiveRecord::Migration
  def change
    create_table :profils do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
