class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
    end
    add_index :roles, :name, unique: true

    change_table :users do |t|
      t.references :role, index: true
    end
  end
end
