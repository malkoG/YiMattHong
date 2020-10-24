class Board < ApplicationRecord
  has_many :notices
  belongs_to :curation, optional: true
end
