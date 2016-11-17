require 'harvested'

class HarvestUsers
  def initialize(harvest_client = Harvest.hardy_client(subdomain: '', username: '', password: ''))
    @harvest_client = harvest_client
  end

  def all
    @harvest_client.users.all
  end
end
