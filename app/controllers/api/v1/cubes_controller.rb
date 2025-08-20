class Api::V1::CubesController <ApplicationController
  before_action :set_cube
  skip_before_action :verify_authenticity_token

def show
  render json: {
    status: 'succes',
    data: @cube.to_json
  }
end

def rotate
  begin
    move = params.fetch(:move, '').to_s
    service = CubeRotationService.new(@cube)
    service.rotate(move)

    render json: {
      status: 'succes',
      message: "Cube rotated with move #{params[:move]}",
      data: @cube.to_json
    }
  rescue ArgumentError => e
    render json: {
      status: 'error',
      message: e.message,
    }, status: :bad_request
  end
end

def reset
  @cube.reset_to_solved!
  
  render json: {
    status: 'succes',
    message: "Cube is solved",
    data: @cube.to_json
  }
end

private
def set_cube
  @cube=RubiksCube.current_cube
end

end