Given(/^an empty point model$/) do
  DatabaseCleaner.clean
  Point.delete_all
end

Given(/^several points$/) do
  DatabaseCleaner.clean
  10.times.each { |index| Point.create!(x: index, y: index) }
end

Given(/^(\d+) rows$/) do |count|
  DatabaseCleaner.clean
  count.to_i.times.each { |index| Row.create!(text: index) }
end

Given(/^(\d+) rows in default order$/) do |count|
  DatabaseCleaner.clean
  count.to_i.times.each { |index| Row.create!(text: index).update_attribute(:order, index) }
end

When(/^I rank them in reverse order$/) do
  Row.all.reverse.each_with_index { |row, index| row.update_attribute(:order, index) }
end

When(/^I move row (\d+) to row (-?\d+)$/) do |start_position, end_position|
  Row.all[start_position.to_i].update_attribute(:order, end_position.to_i)
end

Then(/^ranking is equivalent to all reversed$/) do
  expect(Row.rank.all.to_a).to eq(Row.all.to_a.reverse)
end

Then(/^ranking is equivalent to all rotated (\-\d+)$/) do |positions|
  expect(Row.rank.all.to_a).to eq(Row.all.to_a.rotate(positions.to_i))
end

Then(/^ranking all has no effect$/) do
  expect(Point.rank.all.to_a).to eq(Point.all.to_a)
end

Then(/^row (\d+) is in position (\d+)$/) do |row, position|
  expect(Row.rank.all[position.to_i].id).to eq(row.to_i + 1)
end