class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable

  references_one :sheet

  #field :roles_mask, :type => Integer, :default => 2
  field :roles, :type => Array, :default => ["student"]
  validate :check_roles

  ROLES = %w[admin student intern prof]

  def role?(role)
    roles.include? role.to_s
  end
  def self.with_role(role)
    where(:roles => /#{role}/i)
  end

  private
  def check_roles
    if self.role?("intern") && !self.role?("student")
      errors.add :roles, "a intern has to be a student too"
    end
    if self.role?("prof") && self.role?("student")
      errors.add :roles, "a student can't be prof at the same time'"
    end
  end

end

