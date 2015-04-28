class V1::TalkController < V1::BaseController

  def info

    response = {
      latest_topics: client.latest_topics,
      # notifications: client.
    }

    render json: response, status: 200
  end

  def client
    @client ||= DiscourseApi::Client.new(ENV["DISCOURSE_URL"])
    @client.api_key = ENV["DISCOURSE_API_KEY"]
    @client.api_username = ENV["DISCOURSE_API_USERNAME"]
    @client.connection_options[:ssl] = {verify: false}
    @client
  end
end


