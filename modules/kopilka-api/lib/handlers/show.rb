require './lib/helpers/db'

module KopilkaApi
  class Handlers
      def self.show(event:, context:)
        {
          statusCode: 200,
          body: "#{self.name} with #{Db.status}"
        }
      end
  end
end
