require 'servicelog/version'
require 'servicelog/railtie' if defined?(Rails)
require 'servicelog/middleware'
require 'servicelog/adapters/active_resource'
require 'servicelog/adapters/httparty'

module Servicelog
  extend self

  def store
    RequestStore[:headers] ||= {}
  end

  def store=(store)
    RequestStore[:headers] = store
  end

  def correlation_id
    true
  end
end
