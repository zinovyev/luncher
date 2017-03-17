require 'calendar/calendar'

RSpec.describe Calendar::Calendar do
  let(:c1) do
    c1 = Calendar::Calendar.new Organization.common.first
    c1.date = Date.new(2017, 1, 15)
    c1
  end

  let(:c2) do
    c2 = Calendar::Calendar.new Organization.common.first
    c2.date = Date.new(2015, 2, 28)
    c2
  end

  it 'should always select the first day of the month' do
    expect(c1.date).to be == Date.new(2017, 1, 1)
    expect(c2.date).to be == Date.new(2015, 2, 1)
  end

  it 'should be able to list days of the month' do
    expect(c1.list_days).to be == (1..31).to_a
    expect(c2.list_days).to be == (1..28).to_a
  end

  it 'should provide a valid days matrix' do
    expect(c1.table_days.count).to eq 5
    expect(c2.table_days.count).to eq 4
    expect(c1.table_days[4][3]).to eq nil
    expect(c2.table_days[0][0].day).to eq 1
  end

  it 'should be able to paginate backwards and forwards' do
    expect(c1.paginate(-1).date).to be == Date.new(2016, 12, 1)
    expect(c1.paginate(-2).date).to be == Date.new(2016, 10, 1)
    expect(c1.paginate(4).date).to be == Date.new(2017, 1, 1)
  end
end
