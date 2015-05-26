class CreateRankleIndex < ActiveRecord::Migration
  def change
    create_table(:rankle_index) do |t|
      t.timestamps null: false
    end
  end
end