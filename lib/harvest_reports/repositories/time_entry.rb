class TimeEntry
  attr_reader :id, :hours, :user_id, :project_id, :date

  def initialize(id, hours, user_id, project_id, date)
    @id = id
    @hours = hours
    @user_id = user_id
    @project_id = project_id
    @date = Date.parse(date)
  end

  def project
    Project.find(project_id)
  end

  def user
    User.find(user_id)
  end

  def rounded_hours(rounder: HarvestReports::Reports::Support::HarvestRounder.new)
    rounder.round(hours)
  end

  def self.parse(object)
    self.from_json(object['day_entry'])
  end

  def self.from_json(json)
    TimeEntry.new(json['id'], json['hours'], json['user_id'], json['project_id'], json['spent_at'])
  end

  def self.all_entries
    JSON.load(File.read('./download/all_entries.json')).map do |json|
      TimeEntry.from_json(json)
    end
  end

  def self.billable_entries
    JSON.load(File.read('./download/billable_entries.json')).map do |json|
      TimeEntry.from_json(json)
    end
  end

  def self.nonbillable_entries
    JSON.load(File.read('./download/nonbillable_entries.json')).map do |json|
      TimeEntry.from_json(json)
    end
  end
end
