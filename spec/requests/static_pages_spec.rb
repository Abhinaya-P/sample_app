require 'spec_helper'
describe "Static pages" do
    describe "Home page" do
    	before { visit root_path }
       it "should have the content 'Sample App'" do 
    	#visit root_path
    	#visit home_path
        page.should have_selector('h1',text: 'Sample App') 
       end
       it "should have the title 'Home'" do
       	 #visit root_path
       	 #visit home_path
       	 page.should have_selector('title', 
       	 									:text => "Ruby on Rails Tutorial Sample App | Home")
       	end

        describe "following/followers" do
         let(:user) { FactoryGirl.create(:user)}
         let(:other_user) { FactoryGirl.create(:user)}

         before {
          other_user.follow!(user)
           sign_in user
           visit root_path
         }
         it { page.should have_link("0 following", href: following_user_path(user)) }
         it { page.should have_link("1 follower", href: followers_user_path(user)) }

         end
    end
    describe "Help page" do	
    	it "should have the content 'Help'" do	
    		visit help_path
    		page.should have_selector('h1',:text => 'Help')
        end
        it "should have the base title" do 
        	visit help_path 
        	page.should have_selector('title',
       										:text => "Ruby on Rails Tutorial Sample App")
        end

        it "should not have a custom page title" do
			visit help_path
			page.should_not have_selector('title', :text => '| Help')
		end
    end
    describe "About page" do
    	it "should have the content 'About Us'" do
    		visit about_path
    		page.should have_selector('h1',:text => 'About Us')
    	end
    	it "should have the title 'About Us'" do
       	 visit about_path
       	 page.should have_selector('title', 
       	 									:text => "Ruby on Rails Tutorial Sample App | About Us")
       	end
    end

    describe "Contact page" do
    	it "should have the content 'Contact" do
    		visit contact_path
    		page.should have_selector('h1',:text => 'Contact')
    	end

    	it "should have title 'Contact Us'" do
    		visit contact_path
    		page.should have_selector('title',:text => "Ruby on Rails Tutorial Sample App | Contact Us")
    	end
    end
end