When(/^I update the apple's position attribute to (\d+)$/) do |position|
  @fruit[:apple].update_attribute(:position, position.to_i)
end

When(/^I assign the apple's rank to (\d+)$/) do |position|
  @fruit[:apple].rank position.to_i
end

When(/^I assign the '(.*)' fruit's '(.*)' rank to '(\d+)'$/) do |type, name, position|
  @fruit[type.to_sym].rank name.to_sym, position.to_i
end

When(/^I assign the '(.*)' vegetable's '(.*)' rank to '(\d+)'$/) do |type, name, position|
  @vegetable[type.to_sym].rank name.to_sym, position.to_i
end


Then(/^the '(.*)' fruit's '(.*)' rank is '(\d+)'$/) do |type, name, position|
  expect(@fruit[type.to_sym].position name).to eq(position.to_i)
end

Then(/^the '(.*)' vegetable's '(.*)' rank is '(\d+)'$/) do |type, name, position|
  expect(@vegetable[type.to_sym].position name).to eq(position.to_i)
end
