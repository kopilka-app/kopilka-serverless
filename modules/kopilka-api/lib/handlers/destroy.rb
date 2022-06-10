module KopilkaApi
  class Handlers
      def self.destroy(event:, context:)
        {
          statusCode: 200,
          body: "#{self.name} with event #{event}"
        }
      end
  end
end