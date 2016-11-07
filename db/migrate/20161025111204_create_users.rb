class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :username
      t.string  :password
      t.integer :age
      t.integer :gender_id
      t.integer :job_id
      t.integer :emotion_id
      t.integer :category_id
    
      t.timestamps null: false
    end
  end
end
