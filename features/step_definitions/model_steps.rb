Given(/^an empty point model$/) do
  Point.delete_all
end

Then(/^ranking all has no effect$/) do
  expect(Point.rank.all).to eq(Point.all)
end