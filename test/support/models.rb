#require_relative '../../lib/rankle_index'

class Fruit < ActiveRecord::Base
  has_many :rankle_indices, as: :indexable
end

class Vegetable < ActiveRecord::Base
  has_many :rankle_indices, as: :indexable
end
