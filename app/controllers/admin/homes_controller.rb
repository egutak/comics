class Admin::HomesController < ApplicationController
  def top
    @users = User.page(params[:pege])
  end
end
