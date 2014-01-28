class UserSerializer < ActiveModel::Serializer  
  root false
  embed :ids, include: false
  
  attributes :id,
    :email,
    :authentication_token,
    :weight,
    :gender,
    :upcoming_catalogs,
    :cdai_score_coordinates
end