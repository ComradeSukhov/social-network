shared_context 'time related helpers' do
  class SimpleObject
    attr_reader :created_at

    def initialize
      @created_at = Time.now
    end
  end

  def random_time(start_date, finish_date)
    Time.at(start_date + rand * (finish_date - start_date))
  end

  def next_year_time(obj)
    Time.new(obj.created_at.year + 1)
  end
end
