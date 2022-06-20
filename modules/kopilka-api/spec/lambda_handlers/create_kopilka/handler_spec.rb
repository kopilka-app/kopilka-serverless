require 'test_helper'
require './src/lambda_handlers/create_kopilka/handler'

describe KopilkaApi::LambdaHandler do
  describe '#call' do
    it 'returns a greeting json' do
      assert_equal(
        { statusCode: 200, body: "Hello, Danil" },
        KopilkaApi::LambdaHandler.call(event)
      )
    end
  end
end
