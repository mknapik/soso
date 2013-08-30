class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :name, null: false
      t.string :value, null: false
      t.integer :year, null: false

      t.timestamps
    end
    add_index :settings, [:year, :name], unique: true
  end
end
