# frozen_string_literal: true

require 'test_helper'

class ServicelogTest < ActiveSupport::TestCase
  test 'test that it has a version number' do
    refute_nil ::Servicelog::VERSION
  end
end
