class CreateRecommends < ActiveRecord::Migration
  def change
    create_table :recommends do |t|
      t.integer     :user_id
      t.float       :compare
      t.timestamps null: false
    end
  end
end
