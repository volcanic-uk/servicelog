# frozen_string_literal: true

module Servicelog
  class Configuration
    attr_accessor :adapters, :x_correlation_id

    def initialize
      @adapters = []
      @x_correlation_id = false
    end
  end
end
