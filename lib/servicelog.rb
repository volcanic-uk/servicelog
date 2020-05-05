require 'servicelog/version'
require 'servicelog/configuration'
require 'servicelog/generators/install_generator'
require 'servicelog/railtie' if defined?(Rails)
require 'servicelog/middleware'
require 'servicelog/adapters/active_resource'
require 'servicelog/adapters/httparty'

module Servicelog
  extend self

  delegate :adapters, :x_correlation_id, to: :configuration

  def configuration
    @configuration ||= Configuration.new
  end

  def configure
    yield(configuration)
  end

  def store
    RequestStore[:headers] ||= {}
  end

  def store=(store)
    RequestStore[:headers] = store
  end
end
