class CreateCardResults < ActiveRecord::Migration[7.0]
  def change
    create_table :card_results do |t|
      t.references :study_session, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true
      t.boolean :is_correct

      t.timestamps
    end
  end
end
