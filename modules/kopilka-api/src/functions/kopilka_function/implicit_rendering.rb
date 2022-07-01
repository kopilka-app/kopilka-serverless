module KopilkaFunction
  module ImplicitRendering
    def performed? = @performed
    private def default_render = render

    def process(*)
      super

      default_render unless performed?
    end
  end
end 
