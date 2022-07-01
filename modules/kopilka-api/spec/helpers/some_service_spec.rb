# frozen_string_literal: true

require 'test_helper'
require './src/helpers/some_service'

describe SomeService.call do
  it 'returns event json' do
    assert_equal('SomeService called', SomeService.call)
  end
end
