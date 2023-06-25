class Public::SearchesController < ApplicationController
  def searches
    @books = Book.where(
        'title LIKE ? OR body LIKE ?',
        "%#{params[:keyword]}%",
        "%#{params[:keyword]}%"
      )
  end
end
