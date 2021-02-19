class ApplicationController < ActionController::Base
  helper_method :current_member

  class LoginRequired < StandardError; end

  class Forbidden < StandardError; end

  if Rails.env.production? || ENV['RESCUE_EXCEPTIONS']
    rescue_from StandardError, with: :rescue_internal_server_error
    rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found
    rescue_from ActionController::ParameterMissing, with: :rescue_bad_request
  end

  rescue_from LoginRequired, with: :rescue_login_required
  rescue_from Forbidden, with: :rescue_forbidden

  private

  def current_member
    Member.find_by(id: session[:member_id]) if session[:member_id]
  end

  def login_required
    raise LoginRequired unless current_member
  end

  def rescue_bad_request(exception)
    render 'errors/bad_request', status: :bad_request, layout: 'error', formats: [:html]
  end

  def rescue_login_required(exception)
    render 'errors/login_required', status: :forbidden, layout: 'error', formats: [:html]
  end

  def rescue_forbidden(exception)
    render 'errors/forbidden', status: :forbidden, layout: 'error', formats: [:html]
  end

  def rescue_not_found(exception)
    render 'errors/not_found', status: :not_found, layout: 'error', formats: [:html]
  end

  def rescue_internal_server_error(exception)
    render 'errors/internal_server_error', status: :internal_server_error, layout: 'error', formats: [:html]
  end
end
