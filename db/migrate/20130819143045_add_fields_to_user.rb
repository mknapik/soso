class AddFieldsToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :study_year
      t.date :birth_date
      t.string :index
      t.string :street
      t.string :house
      t.string :city
      t.string :zip
      t.string :phone
      t.references :committee
      t.references :field_of_study
      t.references :specialization
      t.references :faculty
    end

    add_index :users, [:committee_id, :index], unique: true
    add_index :users, :committee_id
    add_index :users, :field_of_study_id
    add_index :users, :faculty_id
    add_index :users, :specialization_id
  end
end
