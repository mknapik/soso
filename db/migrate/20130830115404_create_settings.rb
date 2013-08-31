class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :name, null: false
      t.string :value, null: false
      t.integer :year, null: false
      t.references :committee, index: true

      t.timestamps
    end
    add_index :settings, [:committee_id, :year, :name], unique: true
  end
end
