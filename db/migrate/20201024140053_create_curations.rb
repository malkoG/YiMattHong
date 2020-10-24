class CreateCurations < ActiveRecord::Migration[6.0]
  def change
    create_table :curations do |t|
      t.string :title
      t.string :description

      t.timestamps
    end

    add_reference :boards, :curation, null: true, foreign_key: true
  end
end
