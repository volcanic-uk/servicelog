# frozen_string_literal: true

module Servicelog
  # The Railtie triggering a setup from RAILs to make it configurable
  class Railtie < ::Rails::Railtie
    initializer 'servicelog.insert_middleware' do |app|
      app.middleware.insert_after ActionDispatch::RequestId, Servicelog::Middleware
    end
  end
end
