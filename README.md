# Servicelog

If you have a microservice infrastructure and services are growing everywhere you will release challenges as soon as more service are interconnected and you need to figure out problems.

For this issue the `X-Request-Id` HTTP header was introduced. In Rails the `ActionDispatch::RequestId` creates a unique ID for each request if not already defined by the `X-Request-Id` header. Unfortunatelly if your service connects to another service the passing over of this unique id is not in the scope of the `ActionDispatch::RequestId` middleware.

For that issue Servicelog helps you to use the same `X-Request-Id` for multiple requests.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'servicelog'
```

then execute:

    $ bundle install

Next, you need to run the generator:

    $ rails generate servicelog:install

The generator will install an initializer which describes Servicelog's configuration options.

## Usage

By default Servicelog introduces two new middlewares and deletes the `ActionDispatch::RequestId`. The middlewares introduced by Servicelog are:

- `Servicelog::StoreHeaders` to store the `X-Request-Id` header and make it globally available in your application through `Servicelog.headers`.
- `Servicelog::RequestId` which is similar to `ActionDispatch::RequestId` but it takes the incoming `X-Request-Id` and append a new ID to it, this allows to log a unique request on the back server but also see the calling server ID.

Catching and creating a unique request ID is a great, but to really take advantage of the correlation in a service based architecture you'll need to pass the `X-Request-Id` on each request to the next service. It is up to you to ensure that all the requests in your service send the correct `X-Request-Id` to the next service, although Servilog provides a common list of adapters to override the base class and ensure the `X-Request-Id` is sent.

## Adapters

The `adapters` setting allows you to specify which adapters you want to use to send the `X-Request-Id` in each request.

By default the `adapters` setting is set to `[]` - You can change it in your initializer:

```ruby
Servicelog.configure do |config|
  config.adapters = %i[activeresource httparty]
end
```

Availabale adapters:

- `activeresource` - https://github.com/rails/activeresource
- `httparty` - https://github.com/jnunemaker/httparty

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/volcanic-uk/servicelog. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Servicelog project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/victorperez/servicelog/blob/master/CODE_OF_CONDUCT.md).
