class User < ApplicationRecord
  include ActiveModel::Validations
  has_many :orders, dependent: :delete_all
  belongs_to :organization, inverse_of: :users
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :organization, presence: true
  validates_with PublicOrganizationValidator
  before_validation :become_admin
  scope :admins, -> { where lunches_admin: true }
  scope :admin, -> { admins.limit(1) }
  scope :active, -> { where('approved = TRUE OR lunches_admin = TRUE').all }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  def active_for_authentication?
    super && (approved? || lunches_admin?)
  end

  private

  def become_admin
    return false if User.admin_exists?
    self.organization = Organization.find(1)
    self.lunches_admin = true
    self.approved = true
  end

  class << self
    def admin_exists?
      User.unscoped.admin.present?
    end

    def list_public(organization_id, &_block)
      list = where(lunches_admin: false, organization_id: organization_id)
      if block_given?
        list.each do |user|
          yield user
        end
      end
      list
    end

    def from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        fill_from_omniauth(user, auth)
      end
    end

    def fill_from_omniauth(resource, auth)
      resource.email = auth.info.email
      resource.password = Devise.friendly_token[0, 20]
      resource.name = auth.info.name # assuming the user model has a name
      resource.username = auth.info.email
      resource
    end
  end
end
