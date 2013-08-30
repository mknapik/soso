class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.string :name, null: false
      t.string :full_name, null: false
      t.text :description, null: false
      t.datetime :deadline, null: false

      t.timestamps
    end
    add_index :stages, :name, unique: true
  end
end
