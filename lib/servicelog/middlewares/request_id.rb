# frozen_string_literal: true

require 'request_store'

module Servicelog
  class RequestId
    X_REQUEST_ID = 'X-Request-Id'

    def initialize(app)
      @app = app
    end

    def call(env)
      req = ActionDispatch::Request.new env
      req.request_id = make_request_id(req.x_request_id)

      @app.call(env).tap do |_status, headers, _body|
        headers[X_REQUEST_ID] = req.request_id
      end
    end

    private

    def make_request_id(request_id)
      if request_id.presence
        sanitized_request_id = request_id.gsub(/[^\w\-@.]/, '')
        (sanitized_request_id.split('.').last(6) + [internal_request_id]).join('.')[0..254]
      else
        internal_request_id
      end
    end

    def internal_request_id
      if Servicelog.prefix.present?
        [Servicelog.prefix, SecureRandom.uuid].join('-')[0..35]
      else
        SecureRandom.uuid
      end
    end
  end
end
