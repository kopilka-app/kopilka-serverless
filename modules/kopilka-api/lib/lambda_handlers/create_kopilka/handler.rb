module KopilkaApi
  class LambdaHandler
    def self.call(event:, context:)
      {
        statusCode: 200,
        body: "#{self.name} with event #{event}"
      }
    end
  end
end
