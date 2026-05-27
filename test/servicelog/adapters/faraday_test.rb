# frozen_string_literal: true

require 'test_helper'
require 'servicelog/adapters/faraday'

class FaradayAdapterTest < ActiveSupport::TestCase
  def setup
    Servicelog.headers = { 'X-Request-Id' => 'test-request-id' }
  end

  def teardown
    Servicelog.headers = {}
  end

  test 'Servicelog.headers are injected into Faraday::Request#headers=' do
    request = Faraday::Request.allocate
    request.http_method = :get
    request.headers = Faraday::Utils::Headers.new('Content-Type' => 'application/json')

    assert_equal 'test-request-id', request.headers['X-Request-Id']
    assert_equal 'application/json', request.headers['Content-Type']
  end

  test 'Faraday::Connection.new works without SystemStackError' do
    connection = Faraday.new(url: 'https://example.com')

    assert_kind_of Faraday::Connection, connection
    assert_equal 'test-request-id', connection.headers['X-Request-Id']
  end

  test 'Servicelog.headers are present after creating a connection' do
    Servicelog.headers = { 'X-Request-Id' => 'conn-test-id', 'X-Custom' => 'value' }

    connection = Faraday.new(url: 'https://example.com')

    assert_equal 'conn-test-id', connection.headers['X-Request-Id']
    assert_equal 'value', connection.headers['X-Custom']
  end

  test 'Faraday::Request#headers= merges Servicelog headers with provided hash' do
    request = Faraday::Request.allocate
    request.http_method = :post
    request.headers = Faraday::Utils::Headers.new('Authorization' => 'Bearer token')

    assert_equal 'Bearer token', request.headers['Authorization']
    assert_equal 'test-request-id', request.headers['X-Request-Id']
  end

  test 'no infinite recursion on Faraday::Connection#initialize' do
    assert_nothing_raised do
      10.times { Faraday.new(url: 'https://example.com') }
    end
  end
end
