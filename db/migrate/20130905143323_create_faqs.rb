class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.string :question, null: false, limit: 1000
      t.text :answer, null: false
      t.integer :position
      t.boolean :published, default: false
      t.boolean :public, default: false
      t.references :committee

      t.timestamps
    end
  end
end
