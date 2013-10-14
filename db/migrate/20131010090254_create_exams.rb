class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.references :language, index: true
      t.datetime :datetime
      t.integer :min
      t.integer :max
      t.string :state
      t.references :committee, index: true

      t.timestamps
    end

    create_table :exams_language_grades, primary_key: false do |t|
      t.references :exam
      t.references :language_grade
    end

    add_index :exams_language_grades, [:language_grade_id, :exam_id], unique: true
  end
end
