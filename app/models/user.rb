class User < ApplicationRecord
  include ActiveModel::Validations
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders
  belongs_to :organization, inverse_of: :users
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :organization, presence: true
  validates_with PublicOrganizationValidator
  before_validation :become_admin

  def active_for_authentication?
    super && (self.approved? || self.lunches_admin?)
  end

  private

  def become_admin
    unless admin_exists?
      self.organization = Organization.find(1)
      self.lunches_admin = true
      self.approved = true
    end
  end

  def admin_exists?
    User.where(lunches_admin: true).count.positive?
  end

  class << self
    def list_public(organization_id, &block)
      list = where(lunches_admin: false, organization_id: organization_id)
      if block_given?
        list.each do |user|
          block.call user
        end
      end
      list
    end
  end
end
