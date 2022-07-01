# frozen_string_literal: true

require './src/functions/base'

module KopilkaApi
  class Savings
    extend Base

    def self.create
      response status: 200, body: "#{name} called with params #{params}"
    end

    def self.delete
      response status: 200, body: "#{name} called with params #{params}"
    end

    def self.list
      response status: 200, body: "#{name} called with params #{params}"
    end

    def self.update
      response status: 200, body: "#{name} called with params #{params}"
    end
  end
end
