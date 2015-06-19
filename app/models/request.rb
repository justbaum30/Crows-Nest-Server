class Request < ActiveRecord::Base
  belongs_to :endpoint

  def status_css_class
    self.status ? 'good' : 'bad'
  end
end
