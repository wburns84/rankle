Given(/^an apple$/) do
  DatabaseCleaner.clean
  @fruit ||= {}
  @fruit[:apple] = create :fruit, name: 'apple'
end

Given(/^an orange$/) do
  @fruit[:orange] = create :fruit, name: 'orange'
end

Given(/^a banana$/) do
  @fruit[:banana] = create :fruit, name: 'banana'
end

Then(/^the apple is in position (\d+)$/) do |position|
  expect(@fruit[:apple].position).to eq(position.to_i)
end

Then(/^the orange is in position (\d+)$/) do |position|
  expect(@fruit[:orange].position).to eq(position.to_i)
end

Then(/^the banana is in position (\d+)$/) do |position|
  expect(@fruit[:banana].position).to eq(position.to_i)
end

When(/^I assign the apple's position to (\d+)$/) do |position|
  @fruit[:apple].update_attribute(:position, position.to_i)
end