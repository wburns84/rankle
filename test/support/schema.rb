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
end