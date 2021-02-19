class ErrorsController < ActionController::Base
  layout 'error'

  def show
    ex = request.env['action_dispatch.exception']

    if ex.kind_of?(ActionController::RoutingError)
      render 'not_found', status: :not_found, formats: [:html]
    else
      render 'internal_server_error', status: :internal_server_error, formats: [:html]
    end

  end

end
