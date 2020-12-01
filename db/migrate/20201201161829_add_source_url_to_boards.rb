class AddSourceUrlToBoards < ActiveRecord::Migration[6.0]
  def change
    add_column :boards, :source_url, :string
  end
end
