class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :name
      t.integer :category_id
      t.string :definition
      t.string :author
      t.string :web_link

      t.timestamps
    end
  end
end
