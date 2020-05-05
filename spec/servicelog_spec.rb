# frozen_string_literal: true

RSpec.describe Servicelog do
  it 'has a version number' do
    expect(Servicelog::VERSION).not_to be nil
  end
end
