class Board < ApplicationRecord
  belongs_to :curation, optional: true

  has_many :notices
  has_many :subscriptions
end
