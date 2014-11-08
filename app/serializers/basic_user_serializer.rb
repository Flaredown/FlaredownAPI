class BasicUserSerializer < ActiveModel::Serializer
  root false
  embed :ids, include: false

  attributes :id,
    :email,
    # :authentication_token,
    :invitation_token,
    :invitation_accepted_at,
    :invitation_created_at

    def invitation_token
      object.raw_invitation_token ? object.raw_invitation_token : object.invitation_token
    end
end