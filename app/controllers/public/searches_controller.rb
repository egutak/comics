class Public::SearchesController < ApplicationController
  def searches

    @books = Book.where(
        'title LIKE ? OR body LIKE ?',
        "%#{params[:keyword]}%",
        "%#{params[:keyword]}%"
    )

    books_with_tags = []
    params[:tag_ids].each do |key, value|
      books_with_tags += Tag.find_by(name: key).books if value == "1"
    end

    if books_with_tags.present?
      @books = @books.where(id: books_with_tags.pluck(:id))
    end

  end
end
