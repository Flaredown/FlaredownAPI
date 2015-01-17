class UserSerializer < ActiveModel::Serializer
  root false
  embed :ids, embed: true, include: false

  has_many :treatments, include: true
  has_many :symptoms, include: true

  attributes :id,
    :obfuscated_id,
    :email,
    :authentication_token,
    :locale,
    :symptom_colors,
    :treatment_colors,
    :checked_in_today

end