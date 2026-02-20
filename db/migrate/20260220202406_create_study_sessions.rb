class CreateStudySessions < ActiveRecord::Migration[7.0]
  def change
    create_table :study_sessions do |t|
      t.date :study_date
      t.integer :cards_studied
      t.integer :correct_count

      t.timestamps
    end
  end
end
