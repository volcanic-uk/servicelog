# frozen_string_literal: true

# Ensure that the base code has been loaded before monkeypatching
# If it isn't loaded first, it will overwrite this monkeypatch
require 'faraday'

module Faraday
  class Connection
    alias original_initialize initialize

    def initialize(url = nil, options = nil, &block)
      original_initialize(url, options, &block)
      @headers.update(Servicelog.headers)
    end
  end

  class Request
    def headers=(hash)
      hash.update(Servicelog.headers)
      if headers
        headers.replace hash
      else
        super(hash)
      end
    end
  end
end
