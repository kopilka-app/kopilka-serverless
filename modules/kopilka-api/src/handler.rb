# frozen_string_literal: true

require 'ruby-next'
require './src/functions/savings'

module KopilkaApi
  Route = lambda { |env|
    function_name = env[:context][:functionName].capitalize

    Object.const_get("#{name}::#{function_name}").public_send(:request, env)
  }
end
