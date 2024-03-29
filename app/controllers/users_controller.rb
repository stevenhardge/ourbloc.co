class UsersController < ApplicationController
	before_action :authenticate_owner!
	before_filter :set_user, only: [:show, :edit, :update]


    def show
      #add methods here
      @user = User.find(params[:id])

      respond_to do |format|
        format.html 
      end
    end


  	def edit
    	@user.build_profile if @user.profile.nil?
  	end

  	def update
    	if @user.update(user_params)
      	redirect_to user_profile_path(@user)
    	else
      	render 'edit'
    	end
  	end
    
    
    def follow
        @user = User.find(params[:user])
        current_user.follow!(@user)
    end
    
    def unfollow
        @user = User.find(params[:user])
        current_user.unfollow!(@user)
    end
    
  	private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(profile_attributes: [:id, :name, :cid, :birthday, :sex, :tel, :address, :tagline, :introduction, :avatar])
    end

    def authenticate_owner!
      redirect_to root_path unless user_signed_in? && current_user.to_param == params[:id]
    end

end
    
