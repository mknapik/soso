class AddPositionToSubjectGrade < ActiveRecord::Migration
  def change
    add_column :subject_grades, :position, :integer
  end
end
