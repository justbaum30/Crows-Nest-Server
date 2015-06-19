class Project < ActiveRecord::Base
  has_many :endpoints

  def number_available_endpoints
    count = 0
    self.endpoints.each do |endpoint|
      if endpoint.status
        count = count + 1
      end
    end
    count
  end

  def status
    self.number_available_endpoints > 0
  end

  def status_css_class
    self.status ? 'good' : 'bad'
  end
end
