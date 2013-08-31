class CreateSubjectGrades < ActiveRecord::Migration
  def change
    create_table :subject_grades do |t|
      t.references :user, index: true
      t.references :subject, index: true
      t.float :grade
      t.float :ects

      t.timestamps
    end
  end
end
