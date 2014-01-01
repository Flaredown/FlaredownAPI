class UserSerializer < ActiveModel::Serializer  
  root false
  embed :ids, include: false
  
  attributes :id,
    :email,
    :authentication_token    
end