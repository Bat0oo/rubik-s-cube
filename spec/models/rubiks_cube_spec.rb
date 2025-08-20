require 'rails_helper'

RSpec.describe RubiksCube, type: :model do
  describe 'validations' do
    it 'validates presence of all faces' do
      cube = RubiksCube.new
      expect(cube).not_to be_valid
      expect(cube.errors.attribute_names).to include(:front, :back, :left, :right, :top, :bottom)
    end
  end

  describe '.current_cube' do
    context 'when no cube exists' do
      it 'creates a solved cube' do
        expect(RubiksCube.count).to eq(0)
        cube = RubiksCube.current_cube
        expect(RubiksCube.count).to eq(1)
        expect(cube.front).to eq([['R', 'R', 'R'], ['R', 'R', 'R'], ['R', 'R', 'R']])
      end
    end

    context 'when a cube already exists' do
      let!(:existing_cube) { RubiksCube.create_solved_cube }

      it 'returns the existing cube' do
        expect(RubiksCube.current_cube).to eq(existing_cube)
        expect(RubiksCube.count).to eq(1)
      end
    end
  end

  describe '.create_solved_cube' do
    it 'creates a cube with all faces in solved state' do
      cube = RubiksCube.create_solved_cube
      
      expect(cube.front).to eq([['R', 'R', 'R'], ['R', 'R', 'R'], ['R', 'R', 'R']])
      expect(cube.back).to eq([['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O']])
      expect(cube.left).to eq([['G', 'G', 'G'], ['G', 'G', 'G'], ['G', 'G', 'G']])
      expect(cube.right).to eq([['B', 'B', 'B'], ['B', 'B', 'B'], ['B', 'B', 'B']])
      expect(cube.top).to eq([['W', 'W', 'W'], ['W', 'W', 'W'], ['W', 'W', 'W']])
      expect(cube.bottom).to eq([['Y', 'Y', 'Y'], ['Y', 'Y', 'Y'], ['Y', 'Y', 'Y']])
    end
  end

  describe '#reset_to_solved!' do
    it 'resets cube to solved state' do
      cube = RubiksCube.create_solved_cube
      # Modify the cube
      cube.update!(front: [['B', 'R', 'G'], ['Y', 'R', 'W'], ['O', 'R', 'R']])
      
      cube.reset_to_solved!
      
      expect(cube.front).to eq([['R', 'R', 'R'], ['R', 'R', 'R'], ['R', 'R', 'R']])
      expect(cube.back).to eq([['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O']])
      expect(cube.left).to eq([['G', 'G', 'G'], ['G', 'G', 'G'], ['G', 'G', 'G']])
      expect(cube.right).to eq([['B', 'B', 'B'], ['B', 'B', 'B'], ['B', 'B', 'B']])
      expect(cube.top).to eq([['W', 'W', 'W'], ['W', 'W', 'W'], ['W', 'W', 'W']])
      expect(cube.bottom).to eq([['Y', 'Y', 'Y'], ['Y', 'Y', 'Y'], ['Y', 'Y', 'Y']])
    end
  end

  describe '#to_json' do
    it 'returns hash with all face data' do
      cube = RubiksCube.create_solved_cube
      json = cube.to_json
      
      expect(json).to have_key(:front)
      expect(json).to have_key(:back)
      expect(json).to have_key(:left)
      expect(json).to have_key(:right)
      expect(json).to have_key(:top)
      expect(json).to have_key(:bottom)
      expect(json[:front]).to eq([['R', 'R', 'R'], ['R', 'R', 'R'], ['R', 'R', 'R']])
    end
  end
end