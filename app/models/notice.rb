class Notice < ApplicationRecord
  include PgSearch::Model

  belongs_to :board

  pg_search_scope :search_by_romanized_title, against: :romanized_title,
    using: {
      dmetaphone: {
      },
      tsearch: {
        dictionary: "simple",
      },
      trigram: {
        threshold: 0.3,
        word_similarity: true
      }
    }

  def self.search_by_keyword(keyword)
    search_by_romanized_title(Gimchi.romanize(keyword))
  end
end
