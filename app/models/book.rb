class Book < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_tag_relations, dependent: :destroy
  has_many :tags, through: :book_tag_relations, dependent: :destroy

  validates :title, presence: true
  validates :body,presence: true, length: {maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
