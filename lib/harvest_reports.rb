module HarvestReports
  require 'gli'
  include GLI::App
  extend self

  require_relative './harvest_reports/time_entry_summer'
  require_relative './harvest_reports/harvest_time_entries'
  Dir[File.dirname(__FILE__) + '/**/*.rb'].each { |file| require file }
end
