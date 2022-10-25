# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    if !user_id_in_session
      redirect_to landing_page_path
      flash.notice = "You must be logged in or registered to access your dashboard"
    else
      @user = User.find(user_id_in_session)
      @movies = @user.viewing_parties.map { |party| MovieFacade.details_poro(party.movie_id) }
      @invitees = @user.viewing_parties.flat_map { |party| party.invitees(@user.id) }
    end
  end

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to(dashboard_path)
      flash.notice = 'User Registered Successfully'
    else
      flash.alert = user.errors.full_messages.to_sentence
      render :new
    end
  end

  def login_form
  
  end

  def logout
    # require 'pry'; binding.pry
    session.delete :user_id
    redirect_to landing_page_path
  end

  def login_user
# if passwrod is incorrect, do something
    user = User.find_by(email: params[:email]) 
    if !user
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    else
     user.authenticate(params[:password])
       session[:user_id] = user.id
       flash[:success] = "Welcome, #{user.name}!"
       redirect_to dashboard_path
    end
  end
  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
