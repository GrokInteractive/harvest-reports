require 'csv'

module HarvestReports::Reports::Support
  class CSV
    def self.to_csv(array_of_hashes)
      ::CSV.generate do |csv|
        csv << array_of_hashes.first.keys

        array_of_hashes.each do |hash|
          csv << hash.values
        end
      end
    end
  end
end
