class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.references :committee, index: true

      t.timestamps
    end
    add_index :subjects, [:committee_id, :name], unique: true
  end
end
