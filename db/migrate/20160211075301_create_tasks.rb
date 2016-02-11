class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.references :user, index: true, foreign_key: true
      t.string :state
      t.string :attachment

      t.timestamps null: false
    end
  end
end
