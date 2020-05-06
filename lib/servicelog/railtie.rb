# frozen_string_literal: true

module Servicelog
  class Railtie < ::Rails::Railtie
    initializer 'servicelog.insert_middlewares' do |app|
      app.middleware.insert_after ActionDispatch::RequestId, Servicelog::StoreHeaders
      app.middleware.insert_after ActionDispatch::RequestId, Servicelog::RequestId

      app.middleware.delete ActionDispatch::RequestId
    end
  end
end
