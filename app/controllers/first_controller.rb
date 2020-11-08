class FirstController < ApplicationController
  def hello
    # render plain: 'hello Rails'
    # render json: {name: 'simon', features: 'cool'}
    @xxx = 'controller @ xxx'
    render 'first/hello'
  end
  def hi
    render 'first/hi'
  end
end