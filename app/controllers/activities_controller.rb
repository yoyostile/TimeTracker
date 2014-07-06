class ActivitiesController < ApplicationController

  before_action :authenticate_user!

  def index
    @activities = current_user.activities.order(:created_at)
    @activities = @activities.tagged_with(params[:q]) if params[:q].present?
  end

  def new
    create
  end

  def create
    @activity = current_user.activities.create
    redirect_to edit_activity_path(@activity)
  end

  def edit
    @activity = current_user.activities.find_by_id params[:id]
  end

  def update
    @activity = current_user.activities.find_by_id params[:id]
    @activity.update_attributes activity_params
    render json: { redirect_to: activities_path }
  end

  def destroy
    @activity = current_user.activities.find_by_id params[:id]
    @activity.destroy! if @activity
    render json: { redirect_to: activities_path }
  end

  def finish
    @activity = current_user.activities.find_by_id params[:activity_id]
    @activity.finish!
    render json: { redirect_to: activities_path }
  end

  def resume
    @activity = current_user.activities.find_by_id params[:activity_id]
    @activity.resume!
    render json: { redirect_to: activities_path }
  end

  def tags
    @tags = ActsAsTaggableOn::Tag.where("tags.name ILIKE ?", "%#{params[:term]}%")
    respond_to do |format|
      format.json do
        render json: @tags.collect{ |t| { id: t.id, label: t.name, value: t.name } }
      end
    end
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :notes, :tag_list)
  end

end
