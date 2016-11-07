class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :username
      t.string  :password
      t.integer :age
      t.integer :gender_id
      t.integer :category_id
      t.integer :location_id
      t.integer :weather_id
    
      t.timestamps null: false
    end
  end
end
