class User < ApplicationRecord
  rolify
  include Clearance::User
  after_create :assign_default_role

  # validates :name, presence: true
  # validates :lastname, presence: true
  # validates :email, presence: true, uniqueness: true
  # validates :age, numericality: { greater_than: 0, less_than: 150 }, allow_blank: true

  private

  def assign_default_role
    self.add_role(:customer) if self.roles.blank?
  end

end
