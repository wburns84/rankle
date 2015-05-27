class RankleIndex < ActiveRecord::Base
  belongs_to :indexable, polymorphic: true
end

class Fruit < ActiveRecord::Base
  has_many :rankle_indices, as: :indexable
end

class Vegetable < ActiveRecord::Base
  has_many :rankle_indices, as: :indexable
end
