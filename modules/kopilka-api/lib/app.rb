# frozen_string_literal: true

# frozen_literal: true

module KopilkaApi
  class Handlers
    def self.show(event:, context:)
      {
        statusCode: 200,
        body: "#{self.class} with event #{event}"
      }
    end

    def self.list(event:, context:)
      {
        statusCode: 200,
        body: "#{self.class} with event #{event}"
      }
    end

    def self.create(event:, context:)
      {
        statusCode: 200,
        body: "#{self.class} with event #{event}"
      }
    end

    def self.update(event:, context:)
      {
        statusCode: 200,
        body: "#{self.class} with event #{event}"
      }
    end

    def self.destroy(event:, context:)
      {
        statusCode: 200,
        body: "#{self.class} with event #{event}"
      }
    end
  end
end
