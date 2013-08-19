class RenameIndexToStudentNo < ActiveRecord::Migration
  def change
    rename_column :users, :index, :student_no
  end
end
