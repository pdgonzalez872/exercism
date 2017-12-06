require 'date'

class Gigasecond
  class << self
    def from(date)
      date_with_seconds = add_gigaseconds_to_date(date)
      Time.at(date_with_seconds).utc
    end

    private

    def gigaseconds
      gigaseconds = 10  ** 9
    end

    def add_gigaseconds_to_date(date)
      date.to_i + gigaseconds
    end
  end
end

module BookKeeping
  VERSION = 3 # Where the version number matches the one in the test.
end
