class Api::V1::CurrentUserController < Api::V1::BaseController
  before_filter :only_current_user, except: [:index, :avatar, :favorite_pharmacy]

  # for current user lookup
  def index
    render json: current_user, serializer: CurrentUserSerializer
  end

  def show
    render json: current_user, serializer: CurrentUserSerializer
  end

  def avatar
    if params[:file]
      current_user.update_attribute(:avatar, params[:file])
      render json: {}, status: 200
    else
      render json: {}, status: 400
    end
  end

  def favorite_pharmacy
    favorite_pharmacy_params = params.require(:favorite_pharmacy).permit(
      :dosespot_pharmacy_id, :store_name, :pharmacy_specialties, :address1, :address2,
      :city, :state, :zip_code, :primary_phone, :primary_fax
    )
    pharmacy = Pharmacy.find_by(dosespot_pharmacy_id: favorite_pharmacy_params[:dosespot_pharmacy_id])
    pharmacy ||= Pharmacy.create!(favorite_pharmacy_params)
    current_user.pharmacy = pharmacy
    if current_user.save
      render json: CurrentUserSerializer.new(current_user).to_json, status: 200
    else
      render json: {:success => false, :errors => current_user.errors}, status: 400
    end
  end

  def update
    if current_user.update_attributes(user_params)
      render json: CurrentUserSerializer.new(current_user).to_json, status: 200
    else
      render json: {:success => false, :errors => current_user.errors}, status: 400
    end
  end

  private
  def user_params
    params.require(:current_user).permit(
      %i(prefix first_name middle_name last_name suffix phone_home phone_work phone_cell fax role dob gender email password password_confirmation).push(User.preference_definitions.keys.map{|k| "prefers_#{k}".to_sym}).flatten
    )
  end
  def only_current_user
    four_oh_four unless params[:id].to_i == current_user.id
  end
end