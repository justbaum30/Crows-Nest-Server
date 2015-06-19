class ChangeUrlColumnToEndpointUrl < ActiveRecord::Migration
  def change
    rename_column :endpoints, :url, :endpointUrl
  end
end
