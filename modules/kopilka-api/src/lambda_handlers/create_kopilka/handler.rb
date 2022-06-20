# frozen_string_literal: true


def handler(event:, context:)
  {
    statusCode: 200,
    body: "#{__method__} with event #{event}"
  }
end 

