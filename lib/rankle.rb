require "rankle/version"
require 'active_record'

module Rankle
  def rank
    self
  end
end

ActiveRecord::Base.extend Rankle
