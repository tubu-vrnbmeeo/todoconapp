class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def show
    @profile = current_user.profile
  end

  def edit
    @profile = current_user.prepare_profile
  end

  def update
  end

  private
  def profile_params
  end
end