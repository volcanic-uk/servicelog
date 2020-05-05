# frozen_string_literal: true

require 'request_store'

module Servicelog
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      Servicelog.store = headers(env)
      @app.call(env)
    end

    private

    def headers(env)
      if Servicelog.x_correlation_id
        { 'X-Correlation-Id' => env['action_dispatch.request_id'] }
      else
        { 'X-Request-Id' => env['action_dispatch.request_id'] }
      end
    end
  end
end
