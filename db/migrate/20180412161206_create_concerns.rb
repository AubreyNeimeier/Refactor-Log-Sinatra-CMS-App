class CreateConcerns < ActiveRecord::Migration[5.2]
  def change
    create_table :concerns do |t|
      t.string :file_name
      t.string :name_of_method
      t.string :note
      t.string :category
      t.integer :project_id
    end
  end
end
