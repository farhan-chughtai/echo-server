class EchosController < ApplicationController
  
  def page
    endpoint = Endpoint.find_by(verb: request.method, path: request.path.downcase)
    if endpoint.present?
      render json: endpoint.response["body"], status: endpoint.response["code"]
    else
      render json: { errors: {code: :not_found, detail: "Requested page `#{request.path}` does not exist" } }, status: :not_found
    end 
  end
  
end
