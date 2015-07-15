require 'net/https'
require 'net/http'
require 'uri'
require 'ruby_spark'

class Endpoint < ActiveRecord::Base
  belongs_to :project
  has_many :requests

  def number_successful_requests
    self.requests.where(:status => true).size
  end

  def status_css_class
    self.status ? 'good' : 'bad'
  end

  def notify_status_changed
    old_status = self.status
    new_status = self.number_successful_requests > 0

    if old_status != new_status
      self.update_columns(status: new_status)
      send_notifications_to_devices
    end
  end

  ### Network requests ###

  def send_notifications_to_devices
    if Settings.send_notifications
      #make_parse_api_request
    end

    if self.id == 2235 # TODO: Don't hardcode endpoint id for flag
      if self.status
        lower_flag
      else
        hoist_flag
      end
    end
  end

  def make_parse_api_request
    header = {
        'Content-Type' => 'application/json',
        'X-Parse-Application-Id' => 'rDo0wJWA9ZOvf3oVhx6UW2b5YnVHsxo2ToicQ1GE',
        'X-Parse-REST-API-Key' => 'UR4t91a2yutiqjWp7lyYMNf0DYqUadMen0fVKZiK'
    }
    payload = {
        'channels' => ['crows-nest'],
        'data' => {
            'alert' => ''
        }
    }

    https = Net::HTTP.new('api.parse.com', 443)
    https.use_ssl = true
    req = Net::HTTP::Post.new('/1/push', header)
    req.body = payload.to_json
    res = https.request(req)
    puts "Response #{res.code} #{res.message}: #{res.body}"
  end

  def hoist_flag
    RubySpark.configuration do |config|
      config.access_token = 'd96b9f0c4d42cbfeab281f55abf86de26669e257'
    end

    core = RubySpark::Core.new('55ff6e065075555352311787')
    core.function('hoist', 'hoistDiscover')
  end

  def lower_flag
    RubySpark.configuration do |config|
      config.access_token = 'd96b9f0c4d42cbfeab281f55abf86de26669e257'
    end

    core = RubySpark::Core.new('55ff6e065075555352311787')
    core.function('hoist', 'lowerDiscover')
  end
end
