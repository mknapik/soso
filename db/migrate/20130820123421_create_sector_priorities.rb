class CreateSectorPriorities < ActiveRecord::Migration
  def change
    create_table :sector_priorities do |t|
      t.integer :priority
      t.references :sector, index: true
      t.references :user, index: true

      t.timestamps
    end
    add_index :sector_priorities, [:user_id, :sector_id], unique: true
    add_index :sector_priorities, [:user_id, :priority], unique: true
  end
end
