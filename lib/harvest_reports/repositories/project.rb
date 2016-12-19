require 'json'

class Project
  attr_reader :id, :client_id, :name

  @@filename = './download/projects.json'

  def initialize(id, client_id, name)
    @id = id
    @client_id = client_id
    @name = name
  end

  def client
    Client.find(@client_id)
  end

  def self.filename
    @@filename
  end

  def self.filename=(filename)
    @@filename = filename
  end

  def self.find(id)
    all.select {|project| project.id == id }.first
  end

  def self.from_json(json)
    Project.new(json['id'], json['client_id'], json['name'])
  end

  def self.all
    JSON.load(File.read(filename)).map do |json|
      Project.from_json(json)
    end
  end
end
