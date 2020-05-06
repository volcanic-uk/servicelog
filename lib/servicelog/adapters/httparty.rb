# frozen_string_literal: true

module HTTParty
  module ClassMethods
    def headers(hash = nil)
      default_headers = default_options[:headers] || {}
      default_headers.merge!(Servicelog.headers)

      if hash
        unless hash.respond_to?(:to_hash)
          raise ArgumentError, 'Headers must be an object which responds to #to_hash'
        end

        default_headers.merge!(hash.to_hash)
      else
        default_headers
      end
    end
  end
end
