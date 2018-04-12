class CreateConcerns < ActiveRecord::Migration[5.2]
  def change
    create_table :concerns do |t|
      t.string :filename
      t.integer :line_of_code
      t.string :method_name
      t.string :note
      t.string :category
      t.integer :project_id
    end
  end
end
