ActiveRecord::Schema.define do
  self.verbose = false

  create_table :points, :force => true do |t|
    t.integer :x
    t.integer :y

    t.timestamps null: false
  end

  create_table :rows, :force => true do |t|
    t.string :text

    t.timestamps null: false
  end

  create_table :rankle_indices, :force => true do |t|
    t.integer :indexable_id
    t.string  :indexable_type
    t.integer :position

    t.timestamps null: false
  end
end