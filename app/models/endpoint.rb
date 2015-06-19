class Endpoint < ActiveRecord::Base
  belongs_to :project
  has_many :requests
end
