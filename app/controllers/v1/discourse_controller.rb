require 'single_sign_on'

class V1::DiscourseController < V1::BaseController

  def sso
    secret          = ENV["DISCOURSE_SSO_SECRET"]
    sso             = SingleSignOn.parse(request.query_string, secret)
    sso.email       = current_user.email # from devise
    sso.external_id = current_user.obfuscated_id # from devise
    sso.sso_secret  = secret

    render json: {sso_url: sso.to_url("http://talk.flaredown.com/session/sso_login") }, status: 200
  end
end