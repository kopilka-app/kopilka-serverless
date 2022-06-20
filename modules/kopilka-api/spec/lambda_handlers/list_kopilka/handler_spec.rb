require 'test_helper'
require './src/lambda_handlers/list_kopilka/handler'

describe "handler" do
  let(:event) do
    {
      "httpMethod": "POST"
    }
  end

  it 'returns event json' do
    assert_equal({ statusCode: 200, body: "handler with event #{event}" }, handler(event: event))
  end
end
