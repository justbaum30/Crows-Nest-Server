class RemoveDirtyColumnFromRequest < ActiveRecord::Migration
  def change
    remove_column :requests, :dirty, :boolean
  end
end
