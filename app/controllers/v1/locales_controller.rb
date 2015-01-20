class V1::LocalesController < V1::BaseController


  # Get base localization information plus any catalogs
  #
  # Examples
  #
  #   curl "<domain>/v1/locales/en?user_email=test@test.com&user_token=abc123"
  #
  #   GET locales/en
  #
  #   {
  #     "en": {
  #       "hello": "Hello {{first_name}}",
  #       "catalogs": {
  #         "foo": {
  #           "some_question": "How fantastic do you feel today?"
  #         }
  #       }
  #     }
  #   }
  #
  # Returns 200
  def show
    locale_name = sanitize_locale_name(locale_params["locale"].to_s)
    locale = yaml_to_json_style_interpolation!( File.open("#{Rails.root}/config/locales/#{locale_name}/#{locale_name}_base.yml").read )

    if current_user.active_catalogs.present? # Load each catalog on the current_user into the response
      locale[locale_name][:catalogs] ||= {}

      current_user.active_catalogs.each do |catalog|
        catalog_locale = yaml_to_json_style_interpolation!( File.open("#{Rails.root}/config/locales/#{locale_name}/catalogs/#{catalog}.yml").read )
        locale[locale_name][:catalogs][catalog] = catalog_locale
      end
    end

    render json: locale.to_json, status: 200
  end

  # Rescue any entry of invalid dates and render a json error
  #
  # Examples
  #   GET locale/pirate
  #
  #   {error: "Not found."}
  #
  # Returns 404
  rescue_from Errno::ENOENT, with: :unknown_locale_or_catalog
  def unknown_locale_or_catalog(e)
    raise e unless e.to_s.match(/No such file or directory/)
    render json: {error: "Unknown locale or catalog locale."}, status: 404
  end

  private
  def sanitize_locale_name(filename)
    filename.gsub(/[^0-9A-z.\-]/, '')
  end

  def yaml_to_json_style_interpolation!(yaml_string)
    yaml_interpolation_regex = /%{([\d\w_-]+)}/           # Find any interpolated strings like: ${var}
    yaml_string.gsub!(yaml_interpolation_regex, '{{\1}}') # use Ember I18n style {{var}} interpolation instead
    YAML::load(yaml_string)
  end

  def locale_params
    params.permit(:locale)
  end
end