class LoginController < ApplicationController
  def index
    @client_id = "1e69a1f1b9af4aed8797d3ab11daf567"
    @redirect_uri = "#{request.base_url}/login/callback"

  end

  def callback
    puts "params:", params["code"], "end"
    code = params["code"]

    RestClient.post()
  end 
end
