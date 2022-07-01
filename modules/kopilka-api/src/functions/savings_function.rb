# frozen_string_literal: true

require './functions/application_function'
class SavingsFunction < ApplicationFunction
  before_action :foo, only: [:create]
  after_action  :bar, only: [:create]

  def create
    render json: { text: "#{self.class.name} called with params #{sanitize_params}" }, status: 200
  end

  def delete
    render json: { text: "#{self.class.name} called with params #{params}" }, status: 200 
  end

  def index
    render json: { text: "#{self.class.name} called with params #{params}" }, status: 200
  end

  def update
    render json: { text: "#{self.class.name} called with params #{params}" }, status: 200
  end


  private 
  
  def sanitize_params
    params.require(:savings).permit(:name, :description)
  end

  def foo = puts 'before action called'

  def bar = puts 'after action called'
end
