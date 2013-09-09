class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name, null: false
      # 639.2 code
      t.string :iso_code, limit: 3, null: false
    end
    add_index :languages, :iso_code, unique: true
    add_index :languages, :name, unique: true
  end
end
