class RelationshipsController < ApplicationController

	before_filter :signed_in_user , only: [ :create, :destroy]

	def home
     if signed_in?
        @micropost =current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page]) 
     end
    end

	def create
     @user = User.find(params[:relationship][:followed_id]) 
     current_user.follow!(@user)
     respond to do |format|
         format.html { redirect_to @user }
         format.js
     end
    end

    def destroy
      @user = Relationship.find(params[:id]).followed 
      current_user.unfollow!(@user)
      respond_to do |format|
			format.html { redirect_to @user }
			format.js 
	  end
    end
end
