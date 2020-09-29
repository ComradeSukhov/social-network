module TimeTestingHelper
  class SimpleObject
    attr_reader :created_at

    def initialize
      @created_at = Time.now
    end
  end

  def random_time_between(start_date, finish_date)
    Time.at(start_date + rand * (finish_date - start_date))
  end
end
