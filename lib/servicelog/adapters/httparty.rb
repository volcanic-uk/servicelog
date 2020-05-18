# frozen_string_literal: true

module HTTParty
  module ClassMethods
    alias original_headers headers

    def headers(hash = nil)
      original_headers(hash).merge(Servicelog.headers)
    end
  end
end
