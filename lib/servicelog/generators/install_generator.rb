# frozen_string_literal: true

module Servicelog
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      def copy_initializer
        copy_file 'servicelog.rb', 'config/initializers/servicelog.rb'
      end
    end
  end
end
