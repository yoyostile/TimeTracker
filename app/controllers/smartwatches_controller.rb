class SmartwatchesController < ActionController::Base

  layout 'smartwatch'
  before_action :authenticate_user!

  def show
    @activity = current_user.activities.unfinished.last
  end

  def finish
    @activity = current_user.activities.unfinished.find_by_id(params[:id]).finish!
    render json: { redirect_to: smartwatch_path }
  end

  def resume
    @activity = current_user.activities.find_by_id(params[:id]).resume!
    render json: { redirect_to: smartwatch_path }
  end

  def activities
    @activities = current_user.activities.order('created_at desc')
  end

  def analytics
    @activities = current_user.activities.finished
    @tags = @activities.map(&:tag_list).flatten.uniq
    @data = []
    @tags.each do |tag|
      @data << {
        tag: tag,
        value: @activities.tagged_with(tag).map(&:duration).sum,
        color: "rgba(#{(rand*255).to_i}, #{(rand*255).to_i}, #{(rand*255).to_i}, 1)"
      }
    end
  end

  def start_activity
    current_user.activities.create name: params[:tag], tag_list: params[:tag]
    render json: { redirect_to: smartwatch_path }
  end

end
