# encoding: utf-8
class StaticController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def demo
	  render(:layout => false)
  end
end
