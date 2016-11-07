class CreateMovielikeds < ActiveRecord::Migration
  def change
    create_table :movielikeds do |t|
      t.integer   :movie_id
      t.integer   :user_id
      t.boolean   :liked,  :default => false
      t.timestamps null: false
    end
  end
end
