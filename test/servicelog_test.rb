# frozen_string_literal: true

require 'test_helper'
require 'activeresource'
require 'httparty'

class ServicelogTest < ActiveSupport::TestCase
  def setup
    Servicelog.configuration = nil
  end

  test 'test that it has a version number' do
    refute_nil ::Servicelog::VERSION
  end

  test 'should set the headers' do
    Servicelog.headers = { 'X-Request-Id' => 'external-uu-rid' }
    assert Servicelog.headers['X-Request-Id'].present?
  end

  test 'should set custom adapters' do
    Servicelog.configure do |config|
      config.adapters = %i[activeresource httparty]
    end

    assert_equal %i[activeresource httparty], Servicelog.adapters
  end
end
