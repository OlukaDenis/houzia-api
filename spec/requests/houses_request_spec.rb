require 'rails_helper'

RSpec.describe 'Houses', type: :request do
  let(:user) { create(:user) }
  let!(:houses) { create_list(:house,5, user_id: user.id) }
  let(:house_id) { houses.first.id }
  let(:headers) { valid_headers }

  describe 'GET /houses' do
    before { get '/houses', params: {}, headers: headers }

    context 'when the request is valid' do
      
      it 'should return house list' do
        expect(json).not_to be_empty
        expect(json.size).to eq(5)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

    end
  end

  describe 'GET /houses/:id' do
    before { get "/houses/#{house_id}", params: {}, headers: headers }

    context 'when house exists' do
      
      it 'should return the house' do
        expect(json).not_to be_empty
        res = json['house']
        expect(res['id']).to eq(house_id)
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
    let!(:user) { create(:user) }
    let(:valid_attributes) { { name: 'House', description: 'This is a house', image: 'image.png', price: 3000, user_id: user.id }.to_json }

    context 'when request is valid' do
      before { post '/houses', params: valid_attributes, headers: headers }

      it 'should save the house' do
        expect(json['price']).to eq(3000)
      end

      it 'return status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is not valid' do
      let(:user) { create(:user, admin: false) }
      before { post '/houses', params: valid_attributes, headers: headers }

      it 'should not save the house' do
        expect(response.message).to eq('Unprocessable Entity')
      end

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end

    end
  end

  describe 'PUT /houses/:id' do
    let(:valid_attributes) { { price: 10000 }.to_json }

    context 'when the house exists' do
      before { put "/houses/#{house_id}", params: valid_attributes, headers: headers }

      it 'updates the house' do
        expect(json['price']).to eq(10000)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE /houses/:id' do
    before { delete "/houses/#{house_id}", headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
