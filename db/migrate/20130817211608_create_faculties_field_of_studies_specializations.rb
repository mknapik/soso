class CreateFacultiesFieldOfStudiesSpecializations < ActiveRecord::Migration
  def change
    create_table :faculties do |t|
      t.string :name
      t.references :committee, index: true

      t.timestamps
    end
    add_index :faculties, [:committee_id, :name], unique: true

    create_table :field_of_studies do |t|
      t.string :name
      t.references :faculty, index: true

      t.timestamps
    end
    add_index :field_of_studies, [:faculty_id, :name], unique: true

    create_table :specializations do |t|
      t.string :name
      t.references :field_of_study, index: true

      t.timestamps
    end
    add_index :specializations, [:field_of_study_id, :name], unique: true
  end
end
