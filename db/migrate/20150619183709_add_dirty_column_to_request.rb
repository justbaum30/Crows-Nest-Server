class AddDirtyColumnToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :dirty, :boolean
  end
end
