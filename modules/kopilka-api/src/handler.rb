# frozen_string_literal: true

Dir["./functions/*.rb"].each { |file| require file }

ACTIONS_MAPPING = {
  'savings' => {
    'get' => 'index',
    'post' => 'create',
    'put' => 'update',
    'delete' => 'destroy'
  }
}

Response = Struct.new(:statusCode, :body, :headers) do
   def initialize(s = '', b = {}, h = {}) = super(s,b,h)    
end

# AWS Lambda calls Ruby Lambda
Route = -> (event:, context:) do
  function_name = context.function_name
  request_method = event['httpMethod'].downcase

  env = [ ACTIONS_MAPPING[function_name][request_method], JSON.parse(JSON[event], symbolize_names: true), Response.new ]

  function = Object.const_get(function_name.capitalize + "Function")

  function.public_send(:dispatch, *env)
end
