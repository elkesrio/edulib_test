class Repository < ApplicationRecord
  validates_uniqueness_of :url
end
