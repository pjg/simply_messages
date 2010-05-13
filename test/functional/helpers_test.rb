require File.dirname(__FILE__) + '/../test_helper'
require 'action_controller'
require 'action_controller/test_process'

class Mock
  attr_accessor :errors

  def initialize(opts = {})
    # create Errors object so I could add errors to this mock model
    @errors = ActiveRecord::Errors.new(self)
  end
end

class MocksController < ApplicationController
  def success
    flash.now[:success] = 'We have a success'
    render :inline => '<%= messages_block %>'
  end

  def notice
    flash.now[:notice] = 'We have a notice'
    render :inline => '<%= messages_block %>'
  end

  def error
    flash.now[:error] = 'Error: no luck this time'
    render :inline => '<%= messages_block %>'
  end

  def alert
    flash.now[:alert] = 'Alert: no luck this time'
    render :inline => '<%= messages_block %>'
  end

  def model_error
    flash.now[:error] = 'Model error'
    @mock = Mock.new
    @mock.errors.add('name', 'just having some troubles')
    render :inline => '<%= messages_block %>'
  end
end

class MocksControllerTest < ActionController::TestCase

  def setup
    @controller = MocksController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new

    ActionController::Routing::Routes.draw do |map|
      map.connect ':controller/:action/:id'
    end
  end

  def test_success
    get :success
    assert_select 'div.success p', :text => /We have a success./
  end

  def test_notice
    get :notice
    assert_select 'div.notice p', :text => /We have a notice./
  end

  def test_error
    get :error
    assert_select 'div.error p', :text => /Error: no luck this time./
  end

  def test_alert
    get :alert
    assert_select 'div.alert p', :text => /Alert: no luck this time./
  end

  def test_model_error
    get :model_error
    assert_select 'div.error p', :text => /Model error:/
    assert_select 'div.error ul li', :text => /just having some troubles/
  end

end
