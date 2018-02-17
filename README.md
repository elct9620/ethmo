# Ethmo

The Ethereum `geth` RCP tools for ruby developer

## Requirement

* Ruby 2.4+
* Geth (or IPC capability client)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ethmo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ethmo

## Usage

Current is under development, only support minimal features I need.

### Balance of Account

```ruby
account = Ethmo::Account.new('0x475AFd1a6F1D093263bE16948e1EcA6C4DC37Dcf')
p account.balance
```

### Monitor New Blocks

```ruby
monitor = Ethmo::Monitor.new
monitor.start

# NOTE: It will blocking I/O until stop
monitor.each do |event|
  block = Ethmo::Block.new(event.hash)
  block.transactions.each do |tx|
    next unless tx.transfer?
    puts "From: #{tx.from}"
    puts "To: #{tx.to}"
    puts "Value: #{tx.value} ETH"
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elct9620/ethmo.
