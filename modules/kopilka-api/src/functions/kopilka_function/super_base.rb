
module KopilkaFunction
  class SuperBase
    include KopilkaFunction::Rendering

    def self.dispatch(action_name, request, response)
      new.dispatch(action_name, request, response)
    end

    attr_reader :action_name, :request

    def dispatch(action_name, request, response)
      @action_name = action_name
      @request     = request
      @response    = response

      process(@action_name)
    # rescue => e
     # render json: { request: @request, error: e.message }, status: 500
    # ensure
      @response.to_h
    end

    private

    def process(action_name) = send(action_name)

    def response_body=(body)
      @response.body = body

      @performed = true
    end
  end
end