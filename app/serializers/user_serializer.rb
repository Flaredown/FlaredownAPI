class UserSerializer < ActiveModel::Serializer
  embed :ids

  has_many :treatments, include: true
  # has_many :treatments, include: true
  has_many :symptoms, include: true
  has_many :conditions, include: true

  attributes :id,
    :catalogs,
    :settings,
    :obfuscated_id,
    :intercom_hash,
    :email,
    :authentication_token,
    :locale,
    :symptom_colors,
    :treatment_colors,
    :checked_in_today,
    :settings,
    :created_at

    def catalogs
      object.catalogs
    end
    def treatments
      object.active_treatments
    end

    # for Intercom.io secure mode
    def intercom_hash
      OpenSSL::HMAC.hexdigest("sha256", ENV["INTERCOM_SECRET"], object.email)
    end

end