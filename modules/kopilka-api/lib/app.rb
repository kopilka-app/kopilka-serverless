# frozen_string_literal: true

# frozen_literal: true

module KopilkaApi
  class Handlers
    class << self
      def show(event:, context:)
        {
          statusCode: 200,
          body: "#{self.name} with event #{event}"
        }
      end
  
      def list(event:, context:)
        {
          statusCode: 200,
          body: "#{self.name} with event #{event}"
        }
      end
  
      def create(event:, context:)
        {
          statusCode: 200,
          body: "#{self.name} with event #{event}"
        }
      end
  
      def update(event:, context:)
        {
          statusCode: 200,
          body: "#{self.name} with event #{event}"
        }
      end
  
      def destroy(event:, context:)
        {
          statusCode: 200,
          body: "#{self.name} with event #{event}"
        }
      end
    end
  end
end
