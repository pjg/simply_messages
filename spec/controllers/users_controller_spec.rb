require File.expand_path('../spec_helper', File.dirname(__FILE__))

describe UsersController do

  render_views

  describe "#index" do
    before do
      get :index
    end

    specify { response.should be_success }

    specify { response.should have_selector('div.notice p', :content => 'Good') }
    specify { response.should have_selector('div.success p', :content => 'Good') }
    specify { response.should have_selector('div.alert p', :content => 'Not too good') }
  end

  describe "#create" do
    context "without name" do
      before do
        post :create, :user => { :age => 21 }
      end

      specify { response.should be_success }

      specify { response.should have_selector('div.alert p', :content => "error") }
      specify { response.should have_selector('div.alert li', :content => "Name can't be blank") }
    end

    context "without name and age" do
      before do
        post :create
      end

      specify { response.should be_success }

      specify { response.should have_selector('div.alert p', :content => "error") }
      specify { response.should have_selector('div.alert li', :content => "Name can't be blank") }
      specify { response.should have_selector('div.alert li', :content => "Age can't be blank") }
    end
  end

end
