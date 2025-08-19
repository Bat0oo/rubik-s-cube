class RubiksCube < ApplicationRecord
#W=White-TOP
#Y=Yellow-BOT
#R=Red-FRONT
#O=Orange-BACK
#B=Blue-RIGHT
#G=Green-LEFT
#W-Y, R-O, B-G

validates :front, :back, :left, :right, :top, :bottom, presence: true
def self.current_cube
  first || create_solved_cube  
end

def self.create_solved_cube
  create!(
    front:  [['R', 'R', 'R'], ['R', 'R', 'R'], ['R', 'R', 'R']],
    back:   [['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O']],
    left:   [['G', 'G', 'G'], ['G', 'G', 'G'], ['G', 'G', 'G']],
    right:  [['B', 'B', 'B'], ['B', 'B', 'B'], ['B', 'B', 'B']],
    top:    [['W', 'W', 'W'], ['W', 'W', 'W'], ['W', 'W', 'W']],
    bottom: [['Y', 'Y', 'Y'], ['Y', 'Y', 'Y'], ['Y', 'Y', 'Y']]
  )
end
def reset_to_solved!
  update!(
    front:  [['R', 'R', 'R'], ['R', 'R', 'R'], ['R', 'R', 'R']],
    back:   [['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O']],
    left:   [['G', 'G', 'G'], ['G', 'G', 'G'], ['G', 'G', 'G']],
    right:  [['B', 'B', 'B'], ['B', 'B', 'B'], ['B', 'B', 'B']],
    top:    [['W', 'W', 'W'], ['W', 'W', 'W'], ['W', 'W', 'W']],
    bottom: [['Y', 'Y', 'Y'], ['Y', 'Y', 'Y'], ['Y', 'Y', 'Y']]
  )
end

def to_json
{
  front: front,
  back: back,
  left: left,
  right: right,
  top: top,
  bottom: bottom
}
end
end