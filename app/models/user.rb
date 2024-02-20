class User < ApplicationRecord
  validates :name, presence: true

  has_one :info, dependent: :destroy
end
