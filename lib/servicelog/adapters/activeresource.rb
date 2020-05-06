# frozen_string_literal: true

module ActiveResource
  class Base
    cattr_accessor :static_headers
    self.static_headers = headers

    def self.headers
      static_headers.clone.merge(Servicelog.headers)
    end
  end
end
