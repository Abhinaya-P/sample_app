require 'spec_helper'

describe "AuthenticationPages" do
  

  describe 'Authentication' do
  	subject { page }

  	describe "sign in " do
  	before { visit signin_path }

    it { should have_selector('h1',text: "Sign In")}
    it  { should have_selector('title',text: "Sign In")}

    describe "with invalid information" do
    	before { click_button "Sign In"}
     
        it { should have_selector('div.alert.alert-failure',text: "Invalid") }

        
         describe "visiting another page"	 do
        	it "should not have error" do
        	    click_link "Home" 
        		should_not have_selector('div.alert.alert-failure',text: "Invalid")
        	end
        end
    end

    describe "with valid information" do
    	let(:user) { FactoryGirl.create(:user) }
    	before {
    		fill_in "Email", with: user.email 
    		fill_in "Password", with: user.password 
    		click_button "Sign In"
    	}

    	it { should have_selector('title',text: user.name)}
    	it { should have_link('Profile', href: user_path(user))}
    	it { should have_link('Sign Out', href: signout_path)}
    	it {should_not have_link('Sign In', href: signin_path)}
       
        describe "followed by signout" do
		before { click_link "Sign Out" }
		it { should have_link('Sign In') } 
	    end
    end
   end
  end
end
