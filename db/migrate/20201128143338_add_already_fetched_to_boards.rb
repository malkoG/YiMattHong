class AddAlreadyFetchedToBoards < ActiveRecord::Migration[6.0]
  def change
    add_column :boards, :already_fetched, :boolean, default: false
  end
end
