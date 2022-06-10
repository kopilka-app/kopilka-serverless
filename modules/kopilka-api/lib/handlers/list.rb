module KopilkaApi
  class Handlers
      def self.list(event:, context:)
        {
          statusCode: 200,
          body: "#{self.name} with event #{event}"
        }
      end
  end
end