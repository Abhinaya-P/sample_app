require 'spec_helper'

describe "UserPages" do
  describe "Sign up" do
      before { visit signup_path }

      it "should have heading sign up" do
      	page.should have_selector('h1', text: 'Sign Up')
      end

      it "should have title including sign up" do
      	page.should have_selector('title',text: "Ruby on Rails Tutorial Sample App | Sign Up")
      end
    
  end
end
