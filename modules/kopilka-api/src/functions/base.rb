# frozen_string_literal: true

module KopilkaApi
  using RubyNext
  module Base
    def request(env)
      @@params = env[:event][:queryStringParameters]

      action = env[:event][:httpMethod].downcase

      Object.const_get(name).public_send(action)
    end

    def response(status:, body:) = { statusCode: status, body: body }

    def params = @@params
  end
end
