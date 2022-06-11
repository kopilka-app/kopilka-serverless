# frozen_string_literal: true

module KopilkaApi
  class LambdaHandler
    def self.call(event:, context:)
      {
        statusCode: 200,
        body: "#{name} with event #{event}"
      }
    end
  end
end
