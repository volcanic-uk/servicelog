# frozen_string_literal: true

module Servicelog
  class Configuration
    ADAPTERS_PATH = 'servicelog/adapters'.freeze

    attr_accessor :adapters, :x_correlation_id

    def initialize
      @adapters = []
      @x_correlation_id = false
    end

    def require_adapters
      adapters.each do |adapter|
        require "#{ADAPTERS_PATH}/#{adapter}"
      end
    end
  end
end
