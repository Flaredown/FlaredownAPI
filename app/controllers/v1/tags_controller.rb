class V1::TagsController < V1::BaseController
  def search

    # Single Player
    singleplayer = current_user.tag_counts_on(:tags).named_like(tag_params["name"]).map do |tag|
      { name: tag.name, count: tag.count, scope: "single" }
    end

    # Multiplayer
    multiplayer = ActsAsTaggableOn::Tag.named_like(tag_params["name"]).order("taggings_count desc").limit(10).map do |tag|
      { name: tag.name, count: tag.taggings_count, scope: "multi" }
    end

    render json: (singleplayer+multiplayer).to_json, status: 200
  end

  def popular
    # Multi-player
    results = ActsAsTaggableOn::Tag.order("taggings_count desc").limit(10).map do |tag|
      { name: tag.name, count: tag.taggings_count }
    end

    render json: results.to_json, status: 200
  end

  private
  def tag_params
    params.permit(:name)
  end
end


