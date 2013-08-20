class CreateSectors < ActiveRecord::Migration
  def change
    create_table :sectors do |t|
      t.string :name
      t.references :sector_group, index: true
    end
    add_index :sectors, [:sector_group_id, :name], unique: true
  end
end
