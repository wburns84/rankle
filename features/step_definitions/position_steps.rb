Given(/^a fruit class with a reverse alphabetical default ranking on name$/) do
  Fruit.send :ranks, ->(a, b) { a.name > b.name }
end

When(/^I update the apple's position attribute to (\d+)$/) do |position|
  @fruit[:apple].update_attribute(:position, position.to_i)
end

When(/^I assign the apple's rank to (\d+)$/) do |position|
  @fruit[:apple].rank position.to_i
end
