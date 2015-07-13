class AddStatusColumnToEndpoints < ActiveRecord::Migration
  def change
    add_column :endpoints, :status, :boolean
  end
end
