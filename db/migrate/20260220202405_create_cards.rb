class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.references :pamphlet_version, null: false, foreign_key: true
      t.text :question
      t.text :answer
      t.string :topic

      t.timestamps
    end
  end
end
