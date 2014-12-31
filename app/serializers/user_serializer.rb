class UserSerializer < ActiveModel::Serializer
  root false
  embed :ids, include: false

  attributes :id,
    :email,
    :authentication_token,
    :locale,
    # :weight,
    # :gender,
    :upcoming_catalogs
    # :chart_data,
    # :medication_coordinates,
    # :medications

  # def medications
  #   [1,2,3]
  # end
end