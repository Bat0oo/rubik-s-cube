require 'rails_helper'

RSpec.describe Api::V1::CubesController, type: :controller do
  let!(:cube) { RubiksCube.create_solved_cube }

  describe 'GET #show' do
    it 'returns success response with cube data' do
      get :show
      
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response['status']).to eq('succes') 
      expect(json_response['data']).to have_key('front')
      expect(json_response['data']['front']).to eq([['R', 'R', 'R'], ['R', 'R', 'R'], ['R', 'R', 'R']])
    end
  end

  describe 'POST #rotate' do
    context 'with valid move' do
      it 'rotates cube and returns success' do
        post :rotate, params: { move: 'F' }
        
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response['status']).to eq('succes')
        expect(json_response['message']).to eq('Cube rotated with move F')
        expect(json_response['data']).to have_key('front')
      end

      it 'handles prime moves' do
        post :rotate, params: { move: "F'" }
        
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq("Cube rotated with move F'")
      end
    end

    context 'with invalid move' do
      it 'returns error response' do
        post :rotate, params: { move: 'X' }
        
        expect(response).to have_http_status(:bad_request)
        json_response = JSON.parse(response.body)
        expect(json_response['status']).to eq('error')
        expect(json_response['message']).to include('Invalid move: X')
      end
    end

    context 'with missing move parameter' do
      it 'handles nil move parameter' do
        post :rotate, params: {}
        
        expect(response).to have_http_status(:bad_request)
        json_response = JSON.parse(response.body)
        expect(json_response['status']).to eq('error')
      end
    end
  end

  describe 'POST #reset' do
    it 'resets cube to solved state' do
      cube.update!(front: [['B', 'R', 'G'], ['Y', 'R', 'W'], ['O', 'R', 'R']])
      
      post :reset
      
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response['status']).to eq('succes')
      expect(json_response['message']).to eq('Cube is solved')
      expect(json_response['data']['front']).to eq([['R', 'R', 'R'], ['R', 'R', 'R'], ['R', 'R', 'R']])
      
      cube.reload
      expect(cube.front).to eq([['R', 'R', 'R'], ['R', 'R', 'R'], ['R', 'R', 'R']])
    end
  end
end