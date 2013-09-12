class CreateCommitteesLanguages < ActiveRecord::Migration
  def change
    create_table :committees_languages, id: false do |t|
      t.references :committee
      t.references :language
    end
    add_index :committees_languages, [:committee_id, :language_id], unique: true
  end
end
