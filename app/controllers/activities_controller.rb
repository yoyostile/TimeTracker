class ActivitiesController < ApplicationController

  before_action :authenticate_user!

  def index

  end

  def new
    create
  end

  def edit
    @activity = current_user.activities.find_by_id params[:id]
  end

  def update
    @activity = current_user.activities.find_by_id params[:id]
    @activity.update_attributes activity_params
  end

  def create
    @activity = current_user.activities.create 
    redirect_to edit_activity_path(@activity)
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :notes)
  end

end
