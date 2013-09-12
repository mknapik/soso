class CreateLanguageGrades < ActiveRecord::Migration
  def change
    create_table :language_grades do |t|
      t.references :user, index: true
      t.references :language, index: true
      t.float :grade
      t.integer :year
      t.boolean :paid

      t.timestamps
    end
    add_index :language_grades, %w(language_id user_id year), :unique => true
    add_index :language_grades, %w(language_id user_id)
  end
end
