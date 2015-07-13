class Request < ActiveRecord::Base
  belongs_to :endpoint

  after_update :after_changed_test, :if => :status_changed?

  def after_changed_test
    self.endpoint.notify_status_changed
  end

  def status_css_class
    self.status ? 'good' : 'bad'
  end
end
