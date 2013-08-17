class CreateCountriesCitiesCommittees < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name, null: false, unique: true
      t.string :code, null: false, unique: true
      t.references :languages
    end
    create_table :cities do |t|
      t.string :name, null: false
      t.references :country
    end
    create_table :committees do |t|
      t.string :name, null: false, unique: true
      t.string :code
      t.references :city
    end

    add_index :countries, :name, unique: true
    add_index :countries, :code, unique: true

    add_index :cities, :country_id
    add_index :cities, [:country_id, :name], unique: true

    add_index :committees, :city_id
    add_index :committees, [:city_id, :name], unique: true
  end
end
