class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string  :title
      t.integer  :category_id
      t.string  :director
      t.string  :actor_one
      t.string  :actor_two
      t.string  :actor_three
      t.string  :img_url
      t.float   :score
      t.timestamps null: false
    end
  end
end
