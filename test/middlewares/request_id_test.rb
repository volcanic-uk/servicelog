# frozen_string_literal: true

require 'test_helper'

class RequestIdTest < ActiveSupport::TestCase
  test 'passing on the request id from the outside' do
    assert_match(/\w+-\w+-\w+.\w+-\w+-\w+-\w+/,
      stub_request('HTTP_X_REQUEST_ID' => 'external-uu-rid').request_id)
  end

  test 'ensure that only alphanumeric uurids are accepted' do
    assert_match(/X-Hacked-HeaderStuff/,
      stub_request('HTTP_X_REQUEST_ID' => '; X-Hacked-Header: Stuff').request_id)
  end

  test 'accept Apache mod_unique_id format' do
    mod_unique_id = 'abcxyz@ABCXYZ-0123456789'
    assert_match(/#{mod_unique_id}/,
      stub_request('HTTP_X_REQUEST_ID' => mod_unique_id).request_id)
  end

  test 'ensure that 255 char limit on the request id is being enforced' do
    request_id = stub_request('HTTP_X_REQUEST_ID' => 'X' * 500).request_id
    assert_equal 255, request_id.size
  end

  test 'generating a request id when none is supplied' do
    assert_match(/\w+-\w+-\w+-\w+-\w+/, stub_request.request_id)
  end

  test 'uuid alias' do
    assert_match(/\w+-\w+-\w+.\w+-\w+-\w+-\w+/,
      stub_request('HTTP_X_REQUEST_ID' => 'external-uu-rid').uuid)
  end

  private

  def stub_request(env = {})
    Servicelog::RequestId.new(->(environment) { [200, environment, []] }).call(env)
    ActionDispatch::Request.new(env)
  end
end
