class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :slug, null: false
      t.string :title, null: false
      t.boolean :public, default: true
      t.text :content

      t.timestamps
    end
    add_index :pages, :slug, unique: true
  end
end
