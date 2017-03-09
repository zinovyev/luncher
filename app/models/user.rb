class User < ApplicationRecord
  include ActiveModel::Serializers::JSON
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders
  validates :name, presence: true
  validates :username, presence: true
  before_validation :become_admin

  def attributes
    {
      name: name,
      email: email,
      lunches_admin: lunches_admin, 
    }
  end

  private

  def become_admin
    self.lunches_admin = true unless admin_exists?
  end

  def admin_exists?
    User.where(lunches_admin: true).count.positive?
  end
end
