# frozen_string_literal: true

require 'test_helper'

class StoreHeadersTest < ActiveSupport::TestCase
  test 'should store the HTTP_X_REQUEST_ID header from the outside' do
    stub_request('HTTP_X_REQUEST_ID' => 'external-uu-rid')
    assert_match(/\w+-\w+-\w+.\w+-\w+-\w+-\w+/, Servicelog.headers['X-Request-Id'])
  end

  test 'should store the HTTP_X_REQUEST_ID header when none is supplied' do
    stub_request
    assert_match(/\w+-\w+-\w+-\w+/, Servicelog.headers['X-Request-Id'])
  end

  private

  def stub_request(env = {})
    Servicelog::RequestId.new(->(environment) { [200, environment, []] }).call(env)
    Servicelog::StoreHeaders.new(->(environment) { [200, environment, []] }).call(env)

    ActionDispatch::Request.new(env)
  end
end
