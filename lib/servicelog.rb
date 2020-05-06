# frozen_string_literal: true

require 'servicelog/version'
require 'servicelog/configuration'
require 'servicelog/generators/install_generator'
require 'servicelog/railtie' if defined?(Rails)
require 'servicelog/middlewares/store_headers'
require 'servicelog/middlewares/request_id'

module Servicelog
  module_function

  def configuration
    @configuration ||= Configuration.new
  end

  def configure
    yield(configuration) && configuration.require_adapters
  end

  def headers
    RequestStore[:headers] ||= {}
  end

  def headers=(store)
    RequestStore[:headers] = store
  end

  def adapters
    configuration.adapters
  end
end
