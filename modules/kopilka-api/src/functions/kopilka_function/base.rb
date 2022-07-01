# frozen_string_literal: true
Dir["./functions/kopilka_function/*.rb"].each { |file| require file }

module KopilkaFunction
  class Base < KopilkaFunction::SuperBase
    include KopilkaFunction::Callbacks
    include KopilkaFunction::Params
    include KopilkaFunction::ImplicitRendering
    include KopilkaFunction::Rendering
  end
end
