class ApplicationController < ActionController::API
  include ErrorSerializer

  rescue_from StandardError, with: :standard_error
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def respond_with_errors(object)
    render json: {errors: ErrorSerializer.serialize(object)}, status: :unprocessable_entity
  end

  def record_not_found(exception)
    render json: { errors: {code: :not_found, detail: exception.message } }, status: :not_found
  end

  def standard_error(exception)
    render json: { errors: {code: :internal_server_error, detail: exception.message } }, status: :internal_server_error
  end

end
