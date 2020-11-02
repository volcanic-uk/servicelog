# frozen_string_literal: true

module Servicelog
  class Configuration
    ADAPTERS_PATH = 'servicelog/adapters'

    attr_accessor :adapters, :prefix

    def initialize
      @adapters = []
    end

    def require_adapters
      adapters.each do |adapter|
        require "#{ADAPTERS_PATH}/#{adapter}"
      end
    end
  end
end
