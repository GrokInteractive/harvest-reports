require 'dotenv'
require 'harvested'

class HarvestClient
  def self.create
    Dotenv.load
    Harvest.hardy_client(subdomain: ENV.fetch('SUBDOMAIN'), username: ENV.fetch('USERNAME'), password: ENV.fetch('PASSWORD'))
  end
end
