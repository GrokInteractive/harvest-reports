$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'harvest_reports'

require 'minitest'
require 'minitest/autorun'
require 'pry'

class Minitest::Test

  def setup
    super
    Client.filename = './test/download/clients.json'
    Project.filename = './test/download/projects.json'
    User.filename = './test/download/users.json'
  end

  def teardown
    super
    Client.filename = './test/download/clients.json'
    Project.filename = './test/download/projects.json'
    User.filename = './test/download/users.json'
  end
end
