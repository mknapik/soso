class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.string :name, null: false
      t.string :full_name, null: false
      t.text :description, null: false
      t.datetime :deadline, null: false
      t.references :committee, index: true

      t.timestamps
    end
    add_index :stages, [:committee_id, :name], unique: true
  end
end
