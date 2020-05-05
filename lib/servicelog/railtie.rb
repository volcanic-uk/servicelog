# frozen_string_literal: true

module Servicelog
  class Railtie < ::Rails::Railtie
    initializer 'servicelog.insert_middleware' do |app|
      app.middleware.insert_after ActionDispatch::RequestId, Servicelog::Middleware
    end

    initializer 'servicelog.configure_log_tags' do |app|
      unless app.config.log_tags.nil?
        app.configure do
          config.log_tags = [
            lambda { |request|
              request.headers['X-Correlation-Id'] if Servicelog.x_correlation_id
            }
          ] + app.config.log_tags
        end
      end
    end
  end
end
