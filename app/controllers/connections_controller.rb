class ConnectionsController < ApplicationController
	before_action :set_connection, only: [:destroy]

  def create
  	connection = current_user.connections.create_from_omniauth(auth_hash)
  	if connection.save
  		redirect_to dashboard_path, notice: "Connection created!"
  	else
  		redirect_to dashboard_path, notice: "Something went wrong..."
  	end
  end

  def destroy
  	@connection.destroy
  	redirect_to dashboard_path, notice: "Disconnected"
  end

  def omniauth_failure
  	redirect_to dashboard_path, notice: "Oops, something went wrong..."
  end

  private

  def set_connection
  	@connection = Connection.find(params[:id])
  end

  def auth_hash
  	request.env['omniauth.auth']
  end
end
