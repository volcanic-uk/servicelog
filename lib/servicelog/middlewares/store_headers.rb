# frozen_string_literal: true

require 'request_store'

module Servicelog
  class StoreHeaders
    def initialize(app)
      @app = app
    end

    def call(env)
      Servicelog.headers = headers(env)
      @app.call(env)
    end

    private

    def headers(env)
      { 'X-Request-Id' => env['action_dispatch.request_id'] }
    end
  end
end
