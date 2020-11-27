# frozen_string_literal: true

# Ensure that the base code has been loaded before monkeypatching
# If it isn't loaded first, it will overwrite this monkeypatch
require 'httparty'

module HTTParty
  module ClassMethods
    alias original_headers headers

    def headers(hash = nil)
      original_headers(hash).merge(Servicelog.headers)
    end
  end
end
