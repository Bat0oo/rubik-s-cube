class CubeRotationService
  def initialize(cube)
    @cube = cube
  end

  def rotate(move)
    raise ArgumentError, "Invalid move: " if move.nil? || move.empty?
    case move.upcase
    when 'F'
      rotate_front_clockwise
    when "F'"
      rotate_front_counterclockwise
    when 'B'
      rotate_back_clockwise
    when "B'"
      rotate_back_counterclockwise
    when 'L'
      rotate_left_clockwise
    when "L'"
      rotate_left_counterclockwise
    when 'R'
      rotate_right_clockwise
    when "R'"
      rotate_right_counterclockwise
    when 'U'
      rotate_top_clockwise
    when "U'"
      rotate_top_counterclockwise
    when 'D'
      rotate_bot_clockwise
    when "D'"
      rotate_bot_counterclockwise
    else
      raise ArgumentError, "Invalid move: #{move}. Valid moves: F, F', B, B', L, L', R, R', U, U', D, D'"
    end
    @cube.save!
  end
private

  def rotate_face_clockwise(face_matrix)
    # Rotate 3x3 90 degrees clockwise
    [
      [face_matrix[2][0], face_matrix[1][0], face_matrix[0][0]],
      [face_matrix[2][1], face_matrix[1][1], face_matrix[0][1]],
      [face_matrix[2][2], face_matrix[1][2], face_matrix[0][2]]
    ]
  end
  
  def rotate_face_counterclockwise(face_matrix)
    # Rotate 3x3 90 degrees counterclockwise
    [
      [face_matrix[0][2], face_matrix[1][2], face_matrix[2][2]],
      [face_matrix[0][1], face_matrix[1][1], face_matrix[2][1]],
      [face_matrix[0][0], face_matrix[1][0], face_matrix[2][0]]
    ]
  end
  
  def rotate_front_clockwise
    @cube.front = rotate_face_clockwise(@cube.front)
    
    temp = [@cube.top[2][0], @cube.top[2][1], @cube.top[2][2]]
    @cube.top[2] = [@cube.left[2][2], @cube.left[1][2], @cube.left[0][2]]
    
    @cube.left[0][2] = @cube.bottom[0][0]
    @cube.left[1][2] = @cube.bottom[0][1]
    @cube.left[2][2] = @cube.bottom[0][2]
    
    @cube.bottom[0] = [@cube.right[2][0], @cube.right[1][0], @cube.right[0][0]]
    
    @cube.right[0][0] = temp[0]
    @cube.right[1][0] = temp[1]
    @cube.right[2][0] = temp[2]
  end
  
  def rotate_front_counterclockwise
    @cube.front = rotate_face_counterclockwise(@cube.front)
    
    temp = [@cube.top[2][0], @cube.top[2][1], @cube.top[2][2]]
    @cube.top[2] = [@cube.right[0][0], @cube.right[1][0], @cube.right[2][0]]
    
    @cube.right[0][0] = @cube.bottom[0][2]
    @cube.right[1][0] = @cube.bottom[0][1]
    @cube.right[2][0] = @cube.bottom[0][0]
    
    @cube.bottom[0] = [@cube.left[0][2], @cube.left[1][2], @cube.left[2][2]]
    
    @cube.left[0][2] = temp[2]
    @cube.left[1][2] = temp[1]
    @cube.left[2][2] = temp[0]
  end
  
  def rotate_back_clockwise
    @cube.back = rotate_face_clockwise(@cube.back)

    temp = [@cube.top[0][0], @cube.top[0][1], @cube.top[0][2]]
    @cube.top[0] = [@cube.right[0][2], @cube.right[1][2], @cube.right[2][2]]
    
    @cube.right[0][2] = @cube.bottom[2][2]
    @cube.right[1][2] = @cube.bottom[2][1]
    @cube.right[2][2] = @cube.bottom[2][0]
    
    @cube.bottom[2] = [@cube.left[2][0], @cube.left[1][0], @cube.left[0][0]]
    
    @cube.left[0][0] = temp[2]
    @cube.left[1][0] = temp[1]
    @cube.left[2][0] = temp[0]
  end
  
  def rotate_back_counterclockwise
    @cube.back = rotate_face_counterclockwise(@cube.back)
    
    temp = [@cube.top[0][0], @cube.top[0][1], @cube.top[0][2]]
    @cube.top[0] = [@cube.left[0][0], @cube.left[1][0], @cube.left[2][0]]
    
    @cube.left[0][0] = @cube.bottom[2][2]
    @cube.left[1][0] = @cube.bottom[2][1]
    @cube.left[2][0] = @cube.bottom[2][0]
    
    @cube.bottom[2] = [@cube.right[2][2], @cube.right[1][2], @cube.right[0][2]]
    
    @cube.right[0][2] = temp[0]
    @cube.right[1][2] = temp[1]
    @cube.right[2][2] = temp[2]
  end
  
  def rotate_left_clockwise
    @cube.left = rotate_face_clockwise(@cube.left)
    
    temp = [@cube.top[0][0], @cube.top[1][0], @cube.top[2][0]]
    
    @cube.top[0][0] = @cube.back[2][2]
    @cube.top[1][0] = @cube.back[1][2]
    @cube.top[2][0] = @cube.back[0][2]
    
    @cube.back[0][2] = @cube.bottom[2][0]
    @cube.back[1][2] = @cube.bottom[1][0]
    @cube.back[2][2] = @cube.bottom[0][0]
    
    @cube.bottom[0][0] = @cube.front[0][0]
    @cube.bottom[1][0] = @cube.front[1][0]
    @cube.bottom[2][0] = @cube.front[2][0]
    
    @cube.front[0][0] = temp[0]
    @cube.front[1][0] = temp[1]
    @cube.front[2][0] = temp[2]
  end
  
  def rotate_left_counterclockwise
    @cube.left = rotate_face_counterclockwise(@cube.left)
    
    temp = [@cube.top[0][0], @cube.top[1][0], @cube.top[2][0]]
    
    @cube.top[0][0] = @cube.front[0][0]
    @cube.top[1][0] = @cube.front[1][0]
    @cube.top[2][0] = @cube.front[2][0]
    
    @cube.front[0][0] = @cube.bottom[0][0]
    @cube.front[1][0] = @cube.bottom[1][0]
    @cube.front[2][0] = @cube.bottom[2][0]
    
    @cube.bottom[0][0] = @cube.back[2][2]
    @cube.bottom[1][0] = @cube.back[1][2]
    @cube.bottom[2][0] = @cube.back[0][2]
    
    @cube.back[0][2] = temp[2]
    @cube.back[1][2] = temp[1]
    @cube.back[2][2] = temp[0]
  end
  
  def rotate_right_clockwise
    @cube.right = rotate_face_clockwise(@cube.right)
    
    temp = [@cube.top[0][2], @cube.top[1][2], @cube.top[2][2]]
    
    @cube.top[0][2] = @cube.front[0][2]
    @cube.top[1][2] = @cube.front[1][2]
    @cube.top[2][2] = @cube.front[2][2]
    
    @cube.front[0][2] = @cube.bottom[0][2]
    @cube.front[1][2] = @cube.bottom[1][2]
    @cube.front[2][2] = @cube.bottom[2][2]
    
    @cube.bottom[0][2] = @cube.back[2][0]
    @cube.bottom[1][2] = @cube.back[1][0]
    @cube.bottom[2][2] = @cube.back[0][0]
    
    @cube.back[0][0] = temp[2]
    @cube.back[1][0] = temp[1]
    @cube.back[2][0] = temp[0]
  end
  
  def rotate_right_counterclockwise
    @cube.right = rotate_face_counterclockwise(@cube.right)
    
    temp = [@cube.top[0][2], @cube.top[1][2], @cube.top[2][2]]
    
    @cube.top[0][2] = @cube.back[2][0]
    @cube.top[1][2] = @cube.back[1][0]
    @cube.top[2][2] = @cube.back[0][0]
    
    @cube.back[0][0] = @cube.bottom[2][2]
    @cube.back[1][0] = @cube.bottom[1][2]
    @cube.back[2][0] = @cube.bottom[0][2]
    
    @cube.bottom[0][2] = @cube.front[0][2]
    @cube.bottom[1][2] = @cube.front[1][2]
    @cube.bottom[2][2] = @cube.front[2][2]
    
    @cube.front[0][2] = temp[0]
    @cube.front[1][2] = temp[1]
    @cube.front[2][2] = temp[2]
  end
  
  def rotate_top_clockwise
    @cube.top = rotate_face_clockwise(@cube.top)
    
    temp = [@cube.front[0][0], @cube.front[0][1], @cube.front[0][2]]
    @cube.front[0] = [@cube.right[0][0], @cube.right[0][1], @cube.right[0][2]]
    @cube.right[0] = [@cube.back[0][0], @cube.back[0][1], @cube.back[0][2]]
    @cube.back[0] = [@cube.left[0][0], @cube.left[0][1], @cube.left[0][2]]
    @cube.left[0] = temp
  end
  
  def rotate_top_counterclockwise
    @cube.top = rotate_face_counterclockwise(@cube.top)
    
    temp = [@cube.front[0][0], @cube.front[0][1], @cube.front[0][2]]
    @cube.front[0] = [@cube.left[0][0], @cube.left[0][1], @cube.left[0][2]]
    @cube.left[0] = [@cube.back[0][0], @cube.back[0][1], @cube.back[0][2]]
    @cube.back[0] = [@cube.right[0][0], @cube.right[0][1], @cube.right[0][2]]
    @cube.right[0] = temp
  end
  
  def rotate_bot_clockwise
    @cube.bottom = rotate_face_clockwise(@cube.bottom)
    
    temp = [@cube.front[2][0], @cube.front[2][1], @cube.front[2][2]]
    @cube.front[2] = [@cube.left[2][0], @cube.left[2][1], @cube.left[2][2]]
    @cube.left[2] = [@cube.back[2][0], @cube.back[2][1], @cube.back[2][2]]
    @cube.back[2] = [@cube.right[2][0], @cube.right[2][1], @cube.right[2][2]]
    @cube.right[2] = temp
  end
  
  def rotate_bot_counterclockwise
    @cube.bottom = rotate_face_counterclockwise(@cube.bottom)
    
    temp = [@cube.front[2][0], @cube.front[2][1], @cube.front[2][2]]
    @cube.front[2] = [@cube.right[2][0], @cube.right[2][1], @cube.right[2][2]]
    @cube.right[2] = [@cube.back[2][0], @cube.back[2][1], @cube.back[2][2]]
    @cube.back[2] = [@cube.left[2][0], @cube.left[2][1], @cube.left[2][2]]
    @cube.left[2] = temp
  end
end