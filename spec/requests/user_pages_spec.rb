require 'spec_helper'

describe "UserPages" do
  subject { page }	
  describe "Sign up" do
      before { visit new_user_path }

      it "should have heading sign up" do
      	 should have_selector('h1', text: 'Sign Up')
      end

      it "should have title including sign up" do
      	should have_selector('title',text: "Ruby on Rails Tutorial Sample App | Sign Up")
      end
    
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) } 
    before { visit user_path(user) }
    it { should have_selector('h1', text: user.name) }
    it { should have_selector('title', text: user.name) } 
  end

  describe "user sign in page" do
    describe "when empty form is submitted" do
      before { visit new_user_path }
      it "should not create a user" do
        expect do
          click_button "Create my account"
        end.not_to change(User,:count)
      end
    end

    describe "when submitting a valid form" do
      before { visit new_user_path 
      fill_in "Name", with: "Example user"
      fill_in "Email", with: "user@example.com"
      fill_in "Password", with: "foobar"
      fill_in "Confirmation", with: "foobar"
    }
    it "should create a user" do
      expect do
      click_button "Create my account"
      end.to change(User,:count).by(1)
    end
  end


end
end
