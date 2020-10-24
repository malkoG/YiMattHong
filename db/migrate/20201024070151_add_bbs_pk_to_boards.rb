class AddBbsPkToBoards < ActiveRecord::Migration[6.0]
  def change
    add_column :boards, :bbs_pk, :integer
  end
end
