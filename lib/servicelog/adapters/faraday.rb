# frozen_string_literal: true

# Ensure that the base code has been loaded before monkeypatching
# If it isn't loaded first, it will overwrite this monkeypatch
require 'faraday'

module Servicelog
  FARADAY_MAJOR = Gem::Version.new(Faraday::VERSION).segments.first

  module FaradayConnectionPatch
    def initialize(url = nil, options = nil, &block)
      super
      @headers.update(Servicelog.headers)
    end
  end

  module FaradayRequestHeadersPatch
    def headers=(hash)
      hash.update(Servicelog.headers)
      if headers
        headers.replace hash
      elsif Servicelog::FARADAY_MAJOR >= 2
        member_set(:headers, hash)
      else
        super(hash)
      end
    end
  end
end

Faraday::Connection.prepend(Servicelog::FaradayConnectionPatch)

Faraday::Request.class_eval do
  remove_method :headers= if method_defined?(:headers=) || private_method_defined?(:headers=)
end
Faraday::Request.prepend(Servicelog::FaradayRequestHeadersPatch)
