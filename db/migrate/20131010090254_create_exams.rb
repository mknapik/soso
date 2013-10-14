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

    add_column :language_grades, :exam_id, :integer

    add_index :language_grades, :exam_id
  end
end
