class AnalyticsController < ApplicationController

  before_action :authenticate_user!

  def index
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

end
