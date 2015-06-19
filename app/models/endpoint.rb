class Endpoint < ActiveRecord::Base
  belongs_to :project
  has_many :requests

  def number_successful_requests
    self.requests.where(:status => true).size
  end

  def status
    self.number_successful_requests > 0
  end

end
