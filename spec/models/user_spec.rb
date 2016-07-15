# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe "User" do
  before { @user = User.new(name: "User1", email: "User1@example.com", password: "foobar" , password_confirmation: "foobar")}

  it "should respond to name attribute" do
  	@user.should respond_to(:name)
  end

  it { @user.should respond_to(:authenticate) }

  it "should repsond to email attribute " do
  	@user.should respond_to(:email)
  end

  it "should repsond to password digest attribute" do
  	@user.should respond_to(:password_digest)
  end

  it "should repsond to password attribute" do
  	@user.should respond_to(:password)
  end

  it "should repsond to password confirmation attribute" do
  	@user.should respond_to(:password_confirmation)
  end

  it "object should be a valid object" do
  	@user.should be_valid
  end

  it "name should not be empty" do
  	 @user.name = " "
  	 @user.should_not be_valid
  end

  it "when email is empty" do
  	@user.email = " "
  	@user.should_not be_valid
  end

  it "when name is too long" do
  	@user.name = "a"*51
  	@user.should_not be_valid
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " } 
    it { @user.should_not be_valid }
  end

  describe "when password confirmation is nil" do
      before { @user.password_confirmation = nil}
      it { @user.should_not be_valid } 
    end

  describe "when password doesn't match confirmation" do 
  	before { @user.password_confirmation = "mismatch" } 
  	it { @user.should_not be_valid }
end
  describe "when email format is invalid" do
		it "should be invalid" do
		addresses = %w[user@foo,com user at foo.org example.user@foo.
										foo@bar baz.com foo@bar+baz.com]
		addresses.each do |invalid_address| 
			@user.email = invalid_address
			 @user.should_not be_valid
		end 
		end
   end


  describe "when email format is valid" do 
  	it "should be valid" do
		addresses = %w[user@foo.COM A-US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn] 
		addresses.each do |valid_address|
		@user.email = valid_address
		@user.should be_valid 
	end
  end

  describe "when there is a duplicate email" do
  	it "should be invalid" do
  		user_with_same_email = @user.dup
  		user_with_same_email.save
  		@user.should_not be_valid
    end
   end
   end

   describe "with a password that's too short" do
       before { @user.password = @user.password_confirmation = "a" * 5 }
        it { @user.should_not be_valid }
   end

   describe "return value of authenticate " do
      before { @user.save }
      let(:found_user) { User.find_by_email(@user.email)}

      describe "with valid password" do
        it { @user.should == found_user.authenticate(@user.password)}
      end

      describe "with invalid password " do
        let(:user_with_invalid_password ) { found_user.authenticate("invalid") }
        it { @user.should_not == user_with_invalid_password }
        it { user_with_invalid_password.should be_false }
      end
    end
end
