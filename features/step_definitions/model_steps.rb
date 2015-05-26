Given(/^a '(.*)' model$/) do |name|
  DatabaseCleaner.clean
  name.classify.constantize.delete_all
end

Given(/^a '(.*)' model with a '(.*)' ranking$/) do |klass, ranking|
  step "a '#{klass}' model"
  klass.classify.constantize.send :ranks, ranking.to_sym
end


Given(/^an '(.*)' fruit$/) do |name|
  @fruit ||= {}
  @fruit[name.to_sym] = create :fruit, name: name
end

Given(/^a '(.*)' vegetable$/) do |name|
  @vegetable ||= {}
  @vegetable[name.to_sym] = create :vegetable, name: name
end

Given(/^an empty (.+) model$/) do |klass|
  DatabaseCleaner.clean
  klass.classify.constantize.delete_all
end

Given(/^several fruits$/) do
  DatabaseCleaner.clean
  10.times.each { |index| create :fruit }
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
  count.to_i.times.each { |index| Row.create!(text: index).update_attribute(:position, index) }
end

Given(/^(\d+) even and odd rows$/) do |count|
  DatabaseCleaner.clean
  count.to_i.times.each { |index| Row.create!(text: index.even? ? 'even' : 'odd').update_attribute(:position, index) }
end

When(/^I rank them in reverse order$/) do
  Row.all.reverse.each_with_index { |row, index| row.update_attribute(:position, index) }
end

When(/^I move row (\d+) to row (-?\d+)$/) do |start_position, end_position|
  Row.all[start_position.to_i].update_attribute(:position, end_position.to_i)
end

When(/^I reverse rank the even rows$/) do
  Row.rank(:even)
end

Then(/^ranking is equivalent to all reversed$/) do
  expect(Row.ranked.to_a).to eq(Row.all.to_a.reverse)
end

Then(/^ranking is equivalent to all rotated (\-\d+)$/) do |positions|
  expect(Row.ranked.to_a).to eq(Row.all.to_a.rotate(positions.to_i))
end

Then(/^ranking all has no effect$/) do
  expect(Point.ranked.to_a).to eq(Point.all.to_a)
end

Then(/^row (\d+) is in position (\d+)$/) do |row, position|
  expect(Row.ranked[position.to_i].id).to eq(row.to_i + 1)
end

Given(/^a fruit class with an alphabetical default ranking on name$/) do
  Fruit.send :ranks, ->(a, b) { a.name < b.name }
end

Given(/^a fruit class with a reverse alphabetical default ranking on name$/) do
  Fruit.send :ranks, ->(a, b) { a.name > b.name }
end

Given(/^a 'fruit' class with a 'reverse' ranking$/) do
  Fruit.send :ranks, :reverse
end

Then(/^the ranked fruit array is \[:apple, :orange\]$/) do
  expect(Fruit.ranked.map(&:name)).to eq(['apple', 'orange'])
end
