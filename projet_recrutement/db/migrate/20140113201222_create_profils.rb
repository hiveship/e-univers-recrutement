class CreateProfils < ActiveRecord::Migration
  def change
    create_table :profils do |t|
      t.string :profil_title
      t.string :profil_description

      t.timestamps
    end
  end
end
