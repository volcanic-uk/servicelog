# frozen_string_literal: true

module ActiveResource
  class Connection
    alias original_build_request_headers build_request_headers

    def build_request_headers(headers, http_method, uri)
      original_build_request_headers(headers, http_method, uri).merge(Servicelog.headers)
    end
  end
end
