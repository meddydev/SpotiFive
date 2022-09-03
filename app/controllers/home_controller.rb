class HomeController < ApplicationController
    def index
        if session[:user]
            @name = session[:user]["name"]
            @profile_picture_url = session[:user]["image_url"]
            p "IMAGE URL IS " + @profile_picture_url.to_s
        else
            redirect_to "/"
        end
    end
end
