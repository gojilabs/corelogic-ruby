# frozen_string_literal: true

FactoryBot.define do
  factory :oauth_success_body, class: OpenStruct do
    skip_create
    access_token { Faker::Internet.password }
    expires_in { '3599' }
    token_type { 'Bearer' }
  end

  factory :oauth_error_body, class: OpenStruct do
    skip_create
    fault do
      {
        faultstring: 'Invalid access token',
        detail:      { errorcode: 'oauth.v2.InvalidAccessToken' }
      }
    end
  end
end
