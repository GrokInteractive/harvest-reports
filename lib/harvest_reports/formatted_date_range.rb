class FormattedDateRange
  def initialize(start_date = Date.today, end_date = Date.today.next_month)
    @start_date = start_date
    @end_date = end_date
  end

  def start_date
    @start_date.strftime('%Y%m%d')
  end

  def end_date
    @end_date.strftime('%Y%m%d')
  end

  def self.from_strings(start_date_string, end_date_string)
    extract_date = -> (string) do
      string = String(string)

      year = extract_year(string)
      month = extract_month(string)
      day = extract_day(string)

      Date.new(year, month, day)
    end

    start_date = extract_date.call(start_date_string)
    end_date = extract_date.call(end_date_string)

    new(start_date, end_date)
  end

  def self.to_date
    new(Date.new(2013, 01, 01), Date.today)
  end

  def self.month_from_string(string)
    string = String(string)

    year = extract_year(string)
    month = extract_month(string)

    start_date = Date.new(year, month)

    new(start_date, start_date.next_month.prev_day)
  end

  private

  def self.extract_year(string)
    begin
      Integer(string.split('-').fetch(0, '').chomp, 10).tap do |integer|
        raise ArgumentError unless integer >= 2013
      end
    rescue ArgumentError
      raise ArgumentError.new("The year must be a digit greater than or equal to 2013, but \"#{string}\" was given")
    end
  end

  def self.extract_month(string)
   begin
      Integer(string.split('-').fetch(1, '').chomp, 10).tap do |integer|
        raise ArgumentError unless /0[1-9]|1[0-2]/.match(string)
      end
    rescue ArgumentError
      raise ArgumentError.new("The month must be between 01-12, but \"#{string}\" was given")
    end
  end

  def self.extract_day(string)
   begin
      Integer(string.split('-').fetch(2, '').chomp, 10).tap do |integer|
        raise ArgumentError unless /0[1-9]|1[0-9]|2[0-9]|3[0-1]/.match(string)
      end
    rescue ArgumentError
      raise ArgumentError.new("The day must be between 01-31, but \"#{string}\" was given")
    end
  end
end
