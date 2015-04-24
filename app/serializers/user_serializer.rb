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
    :email,
    :authentication_token,
    :locale,
    :symptom_colors,
    :treatment_colors,
    :checked_in_today,
    :settings

    def catalogs
      object.catalogs
    end
    def treatments
      object.active_treatments
    end

end