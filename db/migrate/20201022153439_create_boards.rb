class CreateBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :boards do |t|
      t.string :category
      t.string :description

      t.timestamps
    end
    add_index :boards, :category
  end
end
