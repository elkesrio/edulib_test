class CreateRepositories < ActiveRecord::Migration[6.0]
  def change
    create_table :repositories do |t|
      t.string :url
      t.integer :nb_of_stars
      t.text :description

      t.timestamps
    end
  end
end
