ActiveRecord::Schema.define do
  self.verbose = false

  create_table :fruits, :force => true do |t|
    t.string :name

    t.timestamps null: false
  end

  create_table :vegetables, :force => true do |t|
    t.string :name

    t.timestamps null: false
  end

  create_table :points, :force => true do |t|
    t.integer :x
    t.integer :y

    t.timestamps null: false
  end

  create_table :rows, :force => true do |t|
    t.string :text

    t.timestamps null: false
  end
end