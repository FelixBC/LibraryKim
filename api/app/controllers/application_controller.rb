class ApplicationController < ActionController::API
  before_action :transform_params

  private
  def transform_params
    request.parameters.deep_transform_keys!(&:underscore)
  end
end
