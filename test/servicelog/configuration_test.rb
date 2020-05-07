# frozen_string_literal: true

require 'test_helper'
require 'activeresource'

class ServicelogTest < ActiveSupport::TestCase
  def setup
    Servicelog.configuration = nil
  end

  test 'default configuration' do
    assert_equal [], Servicelog.adapters
  end

  test 'configure custom values' do
    Servicelog.configure do |config|
      config.adapters = %i[activeresource httparty]
    end

    assert_equal %i[activeresource httparty], Servicelog.adapters
  end
end
