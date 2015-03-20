Given(/^an empty point model$/) do
  Point.delete_all
end

Given(/^several points$/) do
  10.times.each { |index| Point.create(x: index, y: index) }
end

Then(/^ranking all has no effect$/) do
  expect(Point.rank.all.to_a).to eq(Point.all.to_a)
end