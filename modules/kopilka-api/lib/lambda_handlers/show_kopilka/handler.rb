require_relative '../../helpers/some_service'

module KopilkaApi
  class LambdaHandler
    def self.call(event:, context:)
      { statusCode: 200, body: "#{name} with #{SomeService.call}" }
    end
  end
end
