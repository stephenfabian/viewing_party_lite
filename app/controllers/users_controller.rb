# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new; end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to(user_path(user))
      flash.notice = 'User Registered Successfully'
    else
      flash.alert = user.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def user_params
    params.permit(:name, :email)
  end
end
