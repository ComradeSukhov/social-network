# The test suit and its helpers require refactoring
#   because of not very desctiptive names of some variables and methods
require 'rails_helper'
require_relative '../support/helpers/helpers_helper.rb'

RSpec.describe ApplicationHelper, type: :helper do
  include ActiveSupport::Testing::TimeHelpers
  include_context 'time related helpers'

  let!(:simple_object) { SimpleObject.new }

  describe '#insert_year(obj)' do
    context 'when object was created this year' do
      it 'rerurns no directives' do # Directives that used in strftime method
        10.times do
          travel_to random_time(simple_object.created_at,
                                next_year_time(simple_object) - 1.second)

          expect(insert_year(simple_object)).to match(/ */)
        end
      end
    end

    context 'when object was created in any previous year' do
      it 'rerurns a year directive' do
        next_year = next_year_time(simple_object)

        travel_to next_year
        expect(insert_year(simple_object)).to include('%Y')

        10.times do
          travel_to Time.at(next_year + rand(100_000_000))
          expect(insert_year(simple_object)).to include('%Y')
        end
      end
    end
  end

  describe '#creation_time' do
    it 'returns results with different sizes for object created this year' +
       'and object created any other year' do
      10.times do
        travel_to random_time(Time.new(simple_object.created_at.year),
                              simple_object.created_at)
        another_object = SimpleObject.new

        expect(creation_time(simple_object).size)
          .to eq(creation_time(another_object).size)
      end

      next_year = next_year_time(simple_object)

      10.times do
        travel_to random_time(next_year,
                              next_year + rand(50).year)
        another_object = SimpleObject.new

        expect(creation_time(simple_object).size)
          .not_to eq(creation_time(another_object).size)
      end
    end
  end
end
