class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
    	t.string :word
    	t.string :synonym
    	t.string :antonym

      t.timestamps null: false
    end
  end
end
