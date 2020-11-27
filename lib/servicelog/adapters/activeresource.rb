# frozen_string_literal: true

# Ensure that the base code has been loaded before monkeypatching
# If it isn't loaded first, it will overwrite this monkeypatch
require 'activeresource'

module ActiveResource
  class Connection
    alias original_build_request_headers build_request_headers

    def build_request_headers(headers, http_method, uri)
      original_build_request_headers(headers, http_method, uri).merge(Servicelog.headers)
    end
  end
end
