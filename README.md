# Rankle

Rankle provides multi-resource ranking.  It uses a separate join table rather than a resource specific position column.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rankle'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rankle

## Default Behavior

Simply including Rankle is intended to be ineffectual:

```ruby
class Fruit < ActiveRecord::Base
end

Fruit.all.to_a == Fruit.rank.all.to_a # true
```

However, new records will respond to position:

```ruby
apple = Fruit.create!

apple.position # 0
```

## Simple Usage

You can assign an explicit ranking in several ways.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rankle/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
