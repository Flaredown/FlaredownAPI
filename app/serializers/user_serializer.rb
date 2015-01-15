class UserSerializer < ActiveModel::Serializer
  root false
  embed :ids, include: false

  attributes :id,
    :obfuscated_id,
    :email,
    :authentication_token,
    :locale,
    :symptom_colors,
    :treatment_colors,
    :checked_in_today

end