# FlyingTable

Create and destroy tables on the fly.
Quickly build up and teardown tables with class.
Primarily for testing purposes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'flying_table'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install flying_table

## Usage

In your tests to create and destroy tables:
```ruby
    $ @tables = FlyingTable.create(example: {name: :string, created: :date})
```
And when complete:
```ruby
    $ @tables.teardown
```

To use with a block:
```ruby
    $ FlyingTable.with(example: {name: :string, created: :date}) do
    $   # do stuff with Example
    $ end
```

In your tests to create a table with class name Example fields name: :string and created: :date

```ruby
    $ FlyingTable.create(example: {name: :string, created: :date})
```

To create multiple tables:

```ruby
    $ FlyingTable.create(example: {name: :string}, example2: {created: :date})
```

To destroy tables

```ruby
    $ FlyingTable.destroy(:example,:example2)
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/flying_table/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Author
-------

* Chris Moody
* Ian Snyder

License
-------

This is free software released into the public domain.
