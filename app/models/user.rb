class User < ApplicationRecord
  validates :name, presence: true

  has_one :info, dependent: :destroy

  accepts_nested_attributes_for :info
end
