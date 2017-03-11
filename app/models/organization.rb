class Organization < ApplicationRecord
  has_many :users, inverse_of: :organization
  validates :title, presence: true, length: { minimum: 5, maximum: 10 }

  class << self
    def list_public
      where(public: true)  
    end
  end
end
