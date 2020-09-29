require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  include ActiveSupport::Testing::TimeHelpers

  let!(:simple_object) { TimeTestingHelper::SimpleObject.new }
  let!(:next_year)     { Time.new(simple_object.created_at.year + 1) }

  describe '#insert_year_directive_for(obj)', :time_related do
    context 'when object was created this year' do
      it 'returns no directives' do # Directives that used in strftime method
        10.times do
          # Travel to a random time up to the end of the current year
          travel_to random_time_between(simple_object.created_at,
                                        next_year - 1.second)

          expect(insert_year_directive_for(simple_object)).to match(/ */)
        end
      end
    end

    context 'when object was created in any previous year' do
      it 'returns a year directive' do
        travel_to next_year

        expect(insert_year_directive_for(simple_object)).to include('%Y')

        10.times do
          travel_to Time.at(next_year + rand(100_000_000))

          expect(insert_year_directive_for(simple_object)).to include('%Y')
        end
      end
    end
  end

  describe '#formatted_creation_time_of(obj)', :time_related do
    context 'if 2 objects was created in the same year' do
      it 'returns strings with the same size for each object' do
        10.times do
          travel_to random_time_between(Time.new(simple_object.created_at.year),
                                        next_year)
          another_object = TimeTestingHelper::SimpleObject.new

          expect(formatted_creation_time_of(simple_object).size)
            .to eq(formatted_creation_time_of(another_object).size)
        end
      end
    end

    context 'if 2 objects was created in different years' do
      it 'returns strings with a different size for each' do
        10.times do
          travel_to random_time_between(next_year,
                                        next_year + rand(50).year)
          another_object = TimeTestingHelper::SimpleObject.new

          expect(formatted_creation_time_of(simple_object).size)
            .not_to eq(formatted_creation_time_of(another_object).size)
        end
      end
    end
  end
end
