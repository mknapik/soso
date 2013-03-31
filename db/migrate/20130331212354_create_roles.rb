class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
    end
    add_index 'roles', ['name'], :name => 'index_roles_on_name', :unique => true
    add_column :users, :role_id, :integer, null: false, default: 3
  end
end
