class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :date_created
      t.string :summary
      t.string :language
      t.integer :user_id
    end
  end
end
