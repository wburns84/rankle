class CreateRankleIndices < ActiveRecord::Migration
  def change
    create_table :rankle_indices do |t|
      t.string  :indexable_name
      t.integer :indexable_id
      t.string  :indexable_type
      t.integer :indexable_position

      t.timestamps null: false
    end

    add_index :rankle_indices, :indexable_name
    add_index :rankle_indices, :indexable_id
    add_index :rankle_indices, :indexable_type
    add_index :rankle_indices, :indexable_position
  end
end