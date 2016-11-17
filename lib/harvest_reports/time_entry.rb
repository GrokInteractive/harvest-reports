class TimeEntry < OpenStruct
  def self.parse(object)
    self.new(object['day_entry'])
  end

  def rounded_hours(rounder: HarvestRounder.new)
    rounder.round(hours)
  end
end
