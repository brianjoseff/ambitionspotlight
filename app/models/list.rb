class List < ActiveRecord::Base
  has_many :assignments
  has_many :actions, through: :assignments
  belongs_to :user

  accepts_nested_attributes_for :actions, reject_if: :all_blank, allow_destroy: true

  validates :title, presence: true
end
