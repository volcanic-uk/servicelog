# frozen_string_literal: true

require 'servicelog/version'
require 'servicelog/configuration'
require 'servicelog/generators/install_generator'
require 'servicelog/railtie' if defined?(Rails)
require 'servicelog/middleware'

module Servicelog
  module_function

  delegate :adapters, :x_correlation_id, to: :configuration

  def configuration
    @configuration ||= Configuration.new
  end

  def configure
    yield(configuration) && configuration.require_adapters
  end

  def store
    RequestStore[:headers] ||= {}
  end

  def store=(store)
    RequestStore[:headers] = store
  end
end
