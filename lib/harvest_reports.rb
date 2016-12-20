module HarvestReports
  require 'gli'
  include GLI::App
  extend self

  subcommand_option_handling :normal
  arguments :strict

  def load_library
    Dir[File.dirname(__FILE__) + '/**/*.rb'].select do |filename|
      !filename.include?('lib/harvest_reports/reports/gli_commands')
    end.each do |file|
      require file
    end
  end

  def load_gli_commands
    Dir[File.dirname(__FILE__) + '/**/*.rb'].select do |filename|
      filename.include?('lib/harvest_reports/reports/gli_commands')
    end.each do |file|
      require file
    end
  end

  load_library
  load_gli_commands
end
