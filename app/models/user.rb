class User < ApplicationRecord
  rolify
  include Clearance::User
  after_create :assign_default_role

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }
  validates :username, presence: true, uniqueness: true


  private

  def assign_default_role
    self.add_role(:customer) if self.roles.blank?
  end

end
