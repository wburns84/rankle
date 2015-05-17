Given(/^an apple$/) do
  DatabaseCleaner.clean
  @fruit ||= {}
  @fruit[:apple] = create :fruit, name: 'apple'
end

Given(/^an orange$/) do
  @fruit[:orange] = create :fruit, name: 'orange'
end

Then(/^the apple is in position (\d+)$/) do |position|
  expect(@fruit[:apple].position).to eq(position.to_i)
end

Then(/^the orange is in position (\d+)$/) do |position|
  expect(@fruit[:orange].position).to eq(position.to_i)
end

When(/^I move the apple to position (\d+)$/) do |position|
  @fruit[:apple].update_attribute(:position, position.to_i)
end