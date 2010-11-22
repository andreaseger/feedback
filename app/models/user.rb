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

  ROLES = %w[admin student intern prof]

  def role?(role)
    roles.include? role.to_s
  end
  def self.with_role(role)
    where(:roles => /#{role}/i)
  end

end

