module HTTParty
  module ClassMethods
    def headers(h = nil)
      default_headers = default_options[:headers] || {}
      default_headers.merge!(Servicelog.store)

      if h
        raise ArgumentError, 'Headers must be an object which responds to #to_hash' unless h.respond_to?(:to_hash)
        default_headers.merge!(h.to_hash)
      else
        default_headers
      end
    end
  end
end
