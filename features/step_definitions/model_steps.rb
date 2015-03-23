Given(/^an empty point model$/) do
  Point.delete_all
end

Given(/^several points$/) do
  10.times.each { |index| Point.create!(x: index, y: index) }
end

Given(/^(\d+) rows$/) do |count|
  count.to_i.times.each { |index| Row.create!(text: index) }
end

When(/^I rank them in reverse order$/) do
  Row.all.reverse.each_with_index { |row, index| row.update_attribute(:order, index) }
end

Then(/^ranking is equivalent to all reversed$/) do
  expect(Row.rank.all.to_a).to eq(Row.all.to_a.reverse)
end

Then(/^ranking all has no effect$/) do
  expect(Point.rank.all.to_a).to eq(Point.all.to_a)
end