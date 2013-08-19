class CreateCountriesCitiesCommittees < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.references :language, index: true
    end
    add_index :countries, :name, unique: true
    add_index :countries, :code, unique: true

    create_table :cities do |t|
      t.string :name, null: false
      t.references :country, index: true
    end
    add_index :cities, [:country_id, :name], unique: true

    create_table :committees do |t|
      t.string :name, null: false
      t.string :code
      t.references :city, index: true
    end
    add_index :committees, [:city_id, :name], unique: true
  end
end
