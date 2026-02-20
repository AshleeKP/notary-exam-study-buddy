class CreatePamphletVersions < ActiveRecord::Migration[7.0]
  def change
    create_table :pamphlet_versions do |t|
      t.integer :year
      t.text :description

      t.timestamps
    end
  end
end
