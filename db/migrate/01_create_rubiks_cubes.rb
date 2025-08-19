class CreateRubiksCubes < ActiveRecord::Migration[7.1]
  def change
    create_table :rubiks_cubes do |t|
      t.json :front, null: false
      t.json :back, null: false
      t.json :left, null: false
      t.json :right, null: false
      t.json :top, null: false
      t.json :bottom, null: false
      
      t.timestamps
    end
  end
end