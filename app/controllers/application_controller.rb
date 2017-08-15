class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def render_error_response(error)
    render json: { error: error.message }, status: 422
  end
end
