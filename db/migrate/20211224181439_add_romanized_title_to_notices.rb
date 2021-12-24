class AddRomanizedTitleToNotices < ActiveRecord::Migration[6.0]
  def change
    # See https://stackoverflow.com/questions/49639887/adding-trigram-index-to-postgres-table-in-rails-5
    enable_extension 'btree_gist'
    enable_extension 'pg_trgm'
    enable_extension 'fuzzystrmatch'

    add_column :notices, :romanized_title, :string
    add_index :notices, :romanized_title, using: :gist, opclass: {romanized_title: :gist_trgm_ops}

    reversible do |dir|
      dir.up do
        Notice.all.each do |notice|
          notice.update(romanized_title: Gimchi.romanize(notice.title))
        end
      end
    end
  end
end
