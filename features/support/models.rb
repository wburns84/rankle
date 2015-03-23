class RankleIndex < ActiveRecord::Base
  belongs_to :indexable, polymorphic: true
end

class Point < ActiveRecord::Base
  has_many :rankle_indices, as: :indexable
end

class Row < ActiveRecord::Base
  has_many :rankle_indices, as: :indexable
  #ranks :order
end

#class Vector < ActiveRecord::Base
#  ranks :magnitude
#end