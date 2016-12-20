require 'json'

class User
  attr_reader :id, :first_name, :last_name
  @@filename = './download/users.json'

  def initialize(id, first_name, last_name)
    @id = id
    @first_name = first_name
    @last_name = last_name
  end

  def ==(object)
    object.class == self.class && object.id == id
  end

  def self.filename
    @@filename
  end

  def self.filename=(filename)
    @@filename = filename
  end

  def self.find(id)
    all.select {|user| user.id == id }.first
  end

  def self.from_json(json)
    User.new(json['id'], json['first_name'], json['last_name'])
  end

  def self.all
    JSON.load(File.read(filename)).map do |json|
      User.from_json(json)
    end
  end
end

