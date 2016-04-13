# encoding: utf-8
class StaticController < ApplicationController
  def demo
	  render(:layout => false)
  end
end
