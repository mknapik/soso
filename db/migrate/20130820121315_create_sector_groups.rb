class CreateSectorGroups < ActiveRecord::Migration
  def change
    create_table :sector_groups do |t|
      t.string :name
    end
    add_index :sector_groups, :name, unique: true
  end
end
