class SmartwatchesController < ActionController::Base

  layout 'smartwatch'

  def show
    @activity = current_user.activities.unfinished.last
  end

  def finish
    @activity = current_user.activities.unfinished.find_by_id(params[:id]).finish!
    render json: { redirect_to: smartwatch_path }
  end

  def activities
    @activities = current_user.activities
  end

  def start_activity
    current_user.activities.create name: params[:tag], tag_list: params[:tag]
    render json: { redirect_to: smartwatch_path }
  end

end