require 'rails_helper'

RSpec.describe 'Houses', type: :request do
  let(:user) { create(:user) }
  let!(:houses) { create_list(:house, 10, user_id: user.id) }
  let(:house_id) { houses.first.id }
  let(:single_headers) { valid_headers }

  describe 'GET /houses' do
    before { get '/houses', params: {}, headers: single_headers }

    context 'when the request is valid' do
      
      it 'should return house list' do
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

    end
  end

  describe 'GET /houses/:id' do
    before { get "/houses/#{house_id}", params: {}, headers: single_headers }

    context 'when house exists' do
      
      it 'should return the house' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(house_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

    end

    context 'when the house does not exist' do
      let(:house_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find House/)
      end
    end
  end


  describe 'POST /houses' do
    let(:headers) { valid_headers.except('Authorization') }

    def house_headers(token)
      {
        'Authorization' => token.to_s,
        'Content-Type' => 'application/json'
      }
    end

    let(:admin_credentials) do 
      { 
        email: user.email, 
        password: user.password
      }.to_json
    end

    def valid_attributes(id)
      attributes_for(:house,
                    name: 'House',
                    description: 'This is description',
                    price: 3000,
                    user_id: id,
                    image: 'image')
    end

    context 'when the request is valid' do
      before { post '/auth/login', params: admin_credentials, headers: headers }
      
      it 'creates a house' do
        token = json['auth_token']
        post '/houses', params: valid_attributes(user.id), headers: house_headers(token)
        expect(json['price']).to eq(3000)
      end

      it 'Does not create a house without valid parameters' do
        token = json['auth_token']
        post '/houses', headers: house_headers(token), params: {}
        expect(response.status).to eq(422)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end
end
