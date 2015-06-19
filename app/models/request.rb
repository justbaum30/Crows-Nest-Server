class Request < ActiveRecord::Base
  belongs_to :endpoint

  before_update :status_has_changed, :if => :status_changed?

  def status_has_changed
    make_parse_api_request
    if self.id == 5
      if self.status
        lower_flag
      else
        hoist_flag
      end
    end
  end

  def status_css_class
    self.status ? 'good' : 'bad'
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
