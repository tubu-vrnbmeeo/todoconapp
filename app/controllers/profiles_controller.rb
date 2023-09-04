class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:edit, :update]

  def show
    @profile = current_user.profile
  end

  def edit
  end

  def update
    @profile.assign_attributes(profile_params)
    if @profile.save
      redirect_to profile_path, notice: 'Profile updated'
    else
      flash.now[:error] = 'Profile could not updated'
      render :edit
    end
  end

  private
  def profile_params
    params.require(:profile).permit(:user_name, :introduction, :avatar)
  end

  def set_profile
    @profile = current_user.prepare_profile
  end
end