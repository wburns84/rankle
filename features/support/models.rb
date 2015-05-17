class RankleIndex < ActiveRecord::Base
  belongs_to :indexable, polymorphic: true
end

class Fruit < ActiveRecord::Base
  has_many :rankle_indices, as: :indexable
end

class Point < ActiveRecord::Base
  has_many :rankle_indices, as: :indexable
end

class Row < ActiveRecord::Base
  has_many :rankle_indices, as: :indexable
end

#class Vector < ActiveRecord::Base
#  ranks :magnitude
#end