# frozen_string_literal: true

require 'test_helper'
require './lib/app'

describe App::Handler do
  describe '#process' do
    it 'returns a greeting' do
      event = { 'data' => { 'name' => 'World' } }
      assert_equal({ statusCode: 200, body: 'Hello, World, I\'m from App::Handler' }, KopilkaApi::Handlers.show(event: event))
    end
  end
end
