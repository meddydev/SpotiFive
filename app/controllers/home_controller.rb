class HomeController < ApplicationController
    def index
        if session[:user]
            @name = session[:user]["name"]
        else
            redirect_to "/"
        end
    end
end
