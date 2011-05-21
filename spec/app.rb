require 'active_record'
require 'action_controller/railtie'
require 'action_view/railtie'

# database
ActiveRecord::Base.configurations = { 'test' => { :adapter => 'sqlite3', :database => ':memory:' } }
ActiveRecord::Base.establish_connection 'test'

# config
app = Class.new(Rails::Application)
app.config.secret_token = '2jv9wver8j3haskhf23b4j51ho8f8vh1'
app.config.session_store :cookie_store, :key => '_simply_messages_session'
app.config.active_support.deprecation = :log
app.initialize!

# route
app.routes.draw do
  resources :users, :only => [:index, :new, :create]
end

# model
class User < ActiveRecord::Base
  validates_presence_of :name, :age
end

# controllers
class ApplicationController < ActionController::Base
end

class UsersController < ApplicationController
  def index
    flash.now[:notice] = 'Good'
    flash.now[:success] = 'Good'
    flash.now[:alert] = 'Not too good'
    render :inline => '<%= messages_block %>'
  end

  def new
    render :inline => '<%= messages_block %>'
  end

  def create
    @user = User.create(params[:user])
    render :inline => '<%= messages_block %>'
  end
end

# helpers
Object.const_set(:ApplicationHelper, Module.new)

# migration
class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.string :name, :null => false
      t.integer :age, :null => false
    end
  end
end

# I18n
I18n.backend.store_translations :en, :activerecord => { :errors => { :template => { :header => { :one => 'There is one error' } } } }
I18n.backend.store_translations :en, :activerecord => { :errors => { :template => { :header => { :other => 'There are %{count} errors' } } } }
