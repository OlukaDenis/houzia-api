require 'rails_helper'

RSpec.describe 'Favorites', type: :request do
  # Authentication test suite
  describe 'POST /auth/login' do
    # create test user
    let!(:user) { create(:user) }

    def house_headers(token)
      {
        'Authorization' => token.to_s,
        'Content-Type' => 'application/json'
      }
    end
    # set headers for authorization
    let(:headers) { valid_headers.except('Authorization') }
    # set test valid and invalid credentials
    let(:admin_credentials) do
      {
        email: user.email,
        password: user.password
      }.to_json
    end
    def valid_attributes(id)
      attributes_for(:house,
                     name: 'user2',
                     description: 'lorem ipsum',
                     user_id: id,
                     price: 34,
                     image: 'image')
    end

    context 'house requests' do
      before do
        post '/auth/login', params: admin_credentials, headers: headers
      end
      it 'return an empty if thereis no favorite created ' do
        token = json['auth_token']
        get '/favorites', headers: house_headers(token)
        expect(json).to eq([])
      end
    end
  end

  # let(:headers) { valid_headers }

  # describe 'GET /favorites' do

  #   context 'when the request is valid' do
  #     before { get '/favorites', params: {}, headers: headers }

  #     it 'should return all user favorites' do

  #     end

  #     it 'should return status code 200' do
  #       expect(response).to have_http_status(200)
  #     end

  #   end
  # end

  # describe 'POST /favorites' do
  #   let(:user) { create(:user) }
  #   let!(:house) { user.create(:house) }

  #   context 'when the request is valid' do
  #     before { post '/favorites', params: { house_id: house.id }, headers: headers }

  #     it 'should save the favorite' do
  #       expect(json['created_at']).to be(nil)
  #     end

  #     it 'should return status code 201' do
  #       expect(response).to have_http_status(201)
  #     end
  #   end
  # end
end
