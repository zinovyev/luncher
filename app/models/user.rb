class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true
  validates :username, presence: true
  before_validation :become_admin

  private

  def become_admin
    unless admin_exists?
      self.lunches_admin = true
    end 
  end

  def admin_exists?
    User.where(lunches_admin: true).count > 0
  end
end
