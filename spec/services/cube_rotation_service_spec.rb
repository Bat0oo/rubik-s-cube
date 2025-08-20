require 'rails_helper'

RSpec.describe CubeRotationService do
  let!(:cube) { RubiksCube.create_solved_cube }
  let(:service) { CubeRotationService.new(cube) }

  describe '#rotate' do
    context 'with valid moves' do
      it 'handles F (front clockwise) move' do
        expect { service.rotate('F') }.not_to raise_error
        expect(cube.right[0][0]).to eq('W')
        expect(cube.right[1][0]).to eq('W')
        expect(cube.right[2][0]).to eq('W')
      end

      it "handles F' (front counterclockwise) move" do
        expect { service.rotate("F'") }.not_to raise_error
        expect(cube.left[0][2]).to eq('W')
        expect(cube.left[1][2]).to eq('W')
        expect(cube.left[2][2]).to eq('W')
      end

      it 'handles R (right clockwise) move' do
        expect { service.rotate('R') }.not_to raise_error
        expect(cube.top[0][2]).to eq('R')
        expect(cube.top[1][2]).to eq('R')
        expect(cube.top[2][2]).to eq('R')
      end

      it 'handles U (top clockwise) move' do
        expect { service.rotate('U') }.not_to raise_error
        expect(cube.right[0]).to eq(['O', 'O', 'O'])
      end

      it 'saves the cube after rotation' do
        expect(cube).to receive(:save!)
        service.rotate('F')
      end
    end

    context 'with invalid moves' do
      it 'raises ArgumentError for invalid move' do
        expect { service.rotate('X') }.to raise_error(ArgumentError, /Invalid move: X/)
      end

      it 'raises ArgumentError for empty move' do
        expect { service.rotate('') }.to raise_error(ArgumentError, /Invalid move: /)
      end
    end

    context 'case insensitive moves' do
      it 'handles lowercase moves' do
        expect { service.rotate('f') }.not_to raise_error
      end

      it 'handles mixed case moves' do
        expect { service.rotate("r'") }.not_to raise_error
      end
    end
  end

  describe 'face rotation methods' do
    describe '#rotate_face_clockwise' do
      it 'rotates a 3x3 matrix 90 degrees clockwise' do
        face = [['A', 'B', 'C'], ['D', 'E', 'F'], ['G', 'H', 'I']]
        rotated = service.send(:rotate_face_clockwise, face)
        expected = [['G', 'D', 'A'], ['H', 'E', 'B'], ['I', 'F', 'C']]
        expect(rotated).to eq(expected)
      end
    end

    describe '#rotate_face_counterclockwise' do
      it 'rotates a 3x3 matrix 90 degrees counterclockwise' do
        face = [['A', 'B', 'C'], ['D', 'E', 'F'], ['G', 'H', 'I']]
        rotated = service.send(:rotate_face_counterclockwise, face)
        expected = [['C', 'F', 'I'], ['B', 'E', 'H'], ['A', 'D', 'G']]
        expect(rotated).to eq(expected)
      end
    end
  end

  describe 'move combinations' do
    it 'F followed by F\' returns to original state' do
      original_state = RubiksCube.create_solved_cube.to_json
      service.rotate('F')
      service.rotate("F'")
      expect(cube.to_json).to eq(original_state)
    end

    it 'four F moves returns to original state' do
      original_state = RubiksCube.create_solved_cube.to_json
      4.times { service.rotate('F') }
      expect(cube.to_json).to eq(original_state)
    end
  end
end