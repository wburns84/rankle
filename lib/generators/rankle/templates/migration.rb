class CreateRankleIndex < ActiveRecord::Migration
  def change
    create_table(:rankle_index) do |t|
      t.string  :indexable_name
      t.integer :indexable_id
      t.string  :indexable_type
      t.integer :indexable_position

      t.timestamps null: false
    end

    add_index :rankle_index, :indexable_name
    add_index :rankle_index, :indexable_id
    add_index :rankle_index, :indexable_type
    add_index :rankle_index, :indexable_position
  end
end