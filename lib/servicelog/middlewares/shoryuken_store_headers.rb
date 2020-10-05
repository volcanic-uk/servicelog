# frozen_string_literal: true

require 'request_store'

module Servicelog
  class ShoryukenStoreHeaders
    def initialize(app = nil)
      @app = app
    end

    def call(_worker_instance, _queue, sqs_msg, body)
      set_request_id(sqs_msg, body)
      yield
    end

    private

    def set_request_id(sqs_msg, body)
      return if sqs_msg.nil? && body.nil?

      Servicelog.headers['X-Request-Id'] ||= body['job_id'] || sqs_msg.message_id
    end
  end
end
