ActiveRecord::Schema.define do
  self.verbose = false

  create_table :points, :force => true do |t|
    t.integer :x
    t.integer :y

    t.timestamps
  end
end