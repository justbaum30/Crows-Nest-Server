class FixEndpointUrlCapitalization < ActiveRecord::Migration
  def change
    rename_column :endpoints, :endpointUrl, :endpoint_url
  end
end
