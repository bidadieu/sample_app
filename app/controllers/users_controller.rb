class UsersController < ApplicationController

    def show
      @user = User.find(params[:id])
      @title = @user.name
    end

    def new
      @title = "Sign up"
      @user = User.new
    end

    def create
      # raise params[:user].inspect  # prints param value in browser, RT error
      @user = User.new(params[:user])
      if @user.save
        flash[:success] = "Welcome to the Sample App!"
        sign_in @user
        redirect_to user_path(@user)
      else
        @title = "Sign up"
        render 'new'
      end
    end

end
