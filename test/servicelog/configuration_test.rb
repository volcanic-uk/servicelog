# frozen_string_literal: true

require 'test_helper'

class ServicelogTest < ActiveSupport::TestCase
  def setup
    Servicelog.configuration = nil
  end

  test 'default configuration' do
    assert_equal [], Servicelog.adapters
  end
end
