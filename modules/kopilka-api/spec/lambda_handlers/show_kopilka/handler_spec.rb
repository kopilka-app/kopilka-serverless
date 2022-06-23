require 'test_helper'
require './src/lambda_handlers/show_kopilka/handler'

describe "handler" do
  let(:event) do
    {
      "httpMethod": "POST",
      "queryStringParameters": { "id": "1" }
    }
  end

  it 'returns event json' do
    assert_equal({ statusCode: 200, body: "handler with event #{event}" }, handler(event: event))
  end
end
