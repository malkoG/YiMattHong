class CreateNotices < ActiveRecord::Migration[6.0]
  def change
    create_table :notices do |t|
      t.string :title
      t.string :author
      t.string :published_at
      t.string :content
      t.integer :bbs_pk
      t.integer :post_pk
      t.json :attachments
      t.references :board, null: false, foreign_key: true

      t.timestamps
    end
  end
end
