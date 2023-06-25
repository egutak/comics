class Admin::CommentsController < ApplicationController
  def index
    @comments = Comment.page(params[:pege])
  end

  def show
  end
end
