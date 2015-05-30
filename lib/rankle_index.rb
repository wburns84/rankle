require 'ranked-model'

class RankleIndex < ActiveRecord::Base
  belongs_to :indexable, polymorphic: true
end
