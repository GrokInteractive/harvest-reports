require 'json'

class Client
  attr_reader :id, :name

  @@filename = './download/clients.json'

  def initialize(id, name)
    @id = id
    @name = name
  end

  def self.find(id)
    all.select {|client| client.id == id }.first
  end

  def self.from_json(json)
    Client.new(json['id'], json['name'])
  end

  def self.filename
    @@filename
  end

  def self.filename=(filename)
    @@filename = filename
  end

  def self.all
    JSON.load(File.read(filename)).map do |json|
      Client.from_json(json)
    end
  end
end
