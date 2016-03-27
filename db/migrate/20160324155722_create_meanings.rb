class CreateMeanings < ActiveRecord::Migration
  def change
    create_table :meanings do |t|
    	t.references :word
    	t.boolean :figurative
    	t.string :form
    	t.text :meaning
    	t.text :example

      t.timestamps null: false
    end
    add_index :meanings,["word_id"]
  end
end
