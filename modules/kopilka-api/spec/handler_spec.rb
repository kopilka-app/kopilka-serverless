# frozen_string_literal: true

require 'test_helper'
require './src/handler'

describe KopilkaApi::Route do
  describe('#call') do
    let(:event) do
      {
        "queryStringParameters": {
          "name": 'Kopilka',
          "description": 'Kopilka description'
        }
      }
    end

    let(:context) do
      {
        "functionName": 'savings',
        "awsRequestId": '12345',
        "logGroupName": 'kopilka-api',
        "logStreamName": '12345',
        "identity": {
          "principalId": '12345'
        }
      }
    end

    let(:expected_response) do
      {
        statusCode: 200,
        body: 'KopilkaApi::Savings called with params {:name=>"Kopilka", :description=>"Kopilka description"}'
      }
    end

    def do_request
      KopilkaApi::Route.call(event: event, context: context)
    end

    it 'routes to create action' do
      event[:httpMethod] = 'CREATE'
      assert_equal(expected_response, do_request)
    end

    it 'routes to update action' do
      event[:httpMethod] = 'UPDATE'
      assert_equal(expected_response, do_request)
    end

    it 'routes to delete action' do
      event[:httpMethod] = 'DELETE'
      assert_equal(expected_response, do_request)
    end

    it 'routes to list action' do
      event[:httpMethod] = 'LIST'
      assert_equal(expected_response, do_request)
    end
  end
end
