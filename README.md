# Rankle (pre-release)

Rankle provides multi-resource ranking.  It uses a separate join table rather than a resource specific position column.

**Rankle is currently in a pre-release state.  It is not optimized for performance and should not be used in
production applications.  Future work will be tracked with issues.**

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rankle'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rankle

## Getting Started

Before you can use Rankle, you'll need to generate the index table.  Rankle provides a generator to assist with this:

    $ rails g rankle:install

The generator only creates the migration file.  You'll still need to run the migration:

    $ rake db:migrate

## Default Behavior

Simply including Rankle is intended to be ineffectual:

```ruby
class Fruit < ActiveRecord::Base
end

Fruit.all.to_a == Fruit.ranked.to_a # true
```

However, new records will respond to position:

```ruby
apple  = Fruit.create!
orange = Fruit.create!

apple.position  # 0
orange.position # 1
```

The ranked method provides an ordered ActiveRecord::Relation:

```ruby
Fruit.create! name: 'apple'
Fruit.create! name: 'orange'

Fruit.ranked.map(&:name) # ['apple', 'orange']
```

## Simple Usage

You can assign an explicit ranking in several ways.  The position attribute can be set directly:

```ruby
apple.update_attribute :position, 1

apple.position  # 1
orange.position # 0

Fruit.ranked.map(&:name) # ['orange', 'apple']
```

When called with an integer, the rank method will assign the position:

```ruby
apple.rank 0

apple.position  # 0
orange.position # 1

Fruit.ranked.map(&:name) # ['apple', 'orange']
```

You can declare a proc to maintain a functional position ranking:

```ruby
class Fruit < ActiveRecord::Base
  ranks ->(a, b) { a.name < b.name }
end

Fruit.create! name: 'apple'
Fruit.create! name: 'orange'
Fruit.create! name: 'banana'

Fruit.ranked.map(&:name) # ['apple', 'banana', 'orange']
```

## Named Ranking

Passing a symbol to the rank method with a position will update the position to that named rank:

```ruby
apple  = Fruit.create! name: 'apple'
orange = Fruit.create! name: 'orange'

apple.rank  :reverse, 1
orange.rank :reverse, 0

apple.position  # 0
orange.position # 1

apple.position  :reverse # 1
orange.position :reverse # 0

Fruit.ranked.map(&:name)           # ['apple', 'orange']
Fruit.ranked(:reverse).map(&:name) # ['orange', 'apple']
```

Since positions are not stored with an absolute value, the available positions increases by 1 with each call to the rank method:

```ruby
apple  = Fruit.create! name: 'apple'
banana = Fruit.create! name: 'banana'
orange = Fruit.create! name: 'orange'

apple.rank  :reverse, 2 # [apple]
banana.rank :reverse, 1 # [banana, apple]
orange.rank :reverse, 0 # [orange, banana, apple]

apple.position  # 0
banana.position # 1
orange.position # 2

apple.position  :reverse # 1
banana.position :reverse # 2
orange.position :reverse # 0

Fruit.ranked.map(&:name)           # ['apple', 'banana', 'orange']
Fruit.ranked(:reverse).map(&:name) # ['orange', 'apple', 'banana']
```

You can bypass this issue by registering the ranking on the class:

```ruby
class Fruit < ActiveRecord::Base
  ranks :reverse
end

apple  = Fruit.create! name: 'apple'
banana = Fruit.create! name: 'banana'
orange = Fruit.create! name: 'orange'

apple.position  # 0
banana.position # 1
orange.position # 2

apple.position  :reverse # 0
banana.position :reverse # 1
orange.position :reverse # 2

apple.rank  :reverse, 2 # [banana, orange, apple]
banana.rank :reverse, 1 # [banana, orange, apple]
orange.rank :reverse, 0 # [orange, banana, apple]

apple.position  # 0
banana.position # 1
orange.position # 2

apple.position  :reverse # 2
banana.position :reverse # 1
orange.position :reverse # 0

Fruit.ranked.map(&:name)           # ['apple', 'banana', 'orange']
Fruit.ranked(:reverse).map(&:name) # ['orange', 'banana', 'apple']
```

## Multiple Resources

Passing a symbol to the rank method with a position will update the position to that named rank:

```ruby
class Fruit < ActiveRecord::Base
end

class Vegetable < ActiveRecord::Base
end

apple  = Fruit.create!     name: 'apple'
carrot = Vegetable.create! name: 'carrot'

apple.rank  :produce, 0
carrot.rank :produce, 1

apple.position  # 0
carrot.position # 0

apple.position  :produce # 0
carrot.position :produce # 1

Fruit.ranked.map(&:name)               # ['apple']
Vegetable.ranked.map(&:name)           # ['carrot']

Fruit.ranked(:produce).map(&:name)     # ['apple']
Vegetable.ranked(:produce).map(&:name) # ['carrot']
```

Notice that the ranked method can't increase the scope of your query.  Multi-resource relations can be accessed through
the Rankle class which serves as the global ranking scope.

```ruby
Rankle.ranked(:produce).map(&:name)    # ['apple', 'carrot']
```

Passing a symbol to the ranks method will register the resource to that ranking.  This will automatically assign the
default position to new records within the shared ranking:

```ruby
class Fruit
  ranks :produce
end

Class Vegetable
  ranks :produce
end

apple  = Fruit.create!     name: 'apple'
carrot = Vegetable.create! name: 'vegetable'

apple.position  # 0
carrot.position # 0

apple.position  :produce # 0
carrot.position :produce # 1
```

## Scoped Ranking

ActiveRecord scopes work in conjunction to further restrict the ranking:

```ruby
class Fruit
  scope :berries, -> { where "name LIKE ?", '%berry' }
end

Fruit.create! name: 'apple'
Fruit.create! name: 'apricot'
Fruit.create! name: 'banana'
Fruit.create! name: 'bilberry'
Fruit.create! name: 'blackberry'
Fruit.create! name: 'blackcurrant'
Fruit.create! name: 'blueberry'
Fruit.create! name: 'boysenberry'
Fruit.create! name: 'cantaloupe'

Fruit.ranked.map(&:name)         # ['apple', 'apricot', 'banana', 'bilberry', 'blackberry', 'blackcurrant', 'blueberry', 'boysenberry', 'cantaloupe']
Fruit.berries.ranked.map(&:name) # ['bilberry', 'blackberry', 'blueberry', 'boysenberry']
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rankle/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
