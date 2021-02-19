class Member < ApplicationRecord
  has_secure_password

  has_many :entries, dependent: :destroy
  has_one_attached :profile_picture
  attribute :new_profile_picture

  validates :number, presence: true,
                     numericality: {
                       only_integer: true,
                       greater_than: 0,
                       less_than: 100,
                       allow_blank: true
                     },
                     uniqueness: true
  validates :name, presence: true,
                   format: {
                     with: /\A[A-Za-z][A-Za-z0-9]*\z/,
                     allow_blank: true,
                     message: :invalid_member_name
                   },
                   length: { minimum: 2, maximum: 20, allow_blank: true },
                   uniqueness: { case_sensitive: false }
  validates :full_name, presence: true, length: { maximum: 20 }
  validates :email, email: { allow_blank: true }

  attr_accessor :current_password

  validates :password, presence: { if: :current_password }

  before_save do
    profile_picture.attach(new_profile_picture) if new_profile_picture
  end

  class << self
    def search(query)
      rel = order(:number)
      rel = rel.where('name LIKE ? OR full_name LIKE ?', "%#{query}%", "%#{query}%") if query.present?
      rel
    end
  end
end
