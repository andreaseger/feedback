class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable,
  #       :registerable,
  #       :rememberable,
  #       :trackable,
  #       :validatable

  references_one :sheet

  field :nds
  field :firstname   #Vorname
  field :lastname    #Nachname
  field :name
  field :email
  field :cached_dn

  validates_presence_of :nds, :email, :name
  validates_uniqueness_of :nds

  field :roles, :type => Array, :default => ["extern"]
  validate :check_roles

  #scopes
  scope :with_role, lambda { |role| where(:roles => /#{role}/i) }


  ROLES = %w[admin student intern extern]

  def role?(role)
    roles.include? role.to_s
  end

  def dn
    if cached_dn
      return cached_dn
    else
      self.cached_dn = (Ldap.new).fetchDN(nds)
    end
  end
  def dn=(value)
    self.cached_dn = value
  end

  def self.create_with_ldap!(entry)
    if entry.class == Net::LDAP::Entry.new.class
      u = new( :nds => entry.cn,
                :dn  => entry.dn,
                :firstname => entry.urrzgivenname,
                :lastname => entry.urrzsurname,
                :name => entry.urrzfullname,
                :email => entry.mail,
                :roles => entry.dn.include?("stud") ? ["student"] : ["extern"] )
      if u.save
        return u
      end
    end
    nil
  end

  private
  def check_roles
    if self.role?("intern") && !self.role?("student")
      errors.add :roles, "a intern has to be a student too"
    end
    if self.role?("extern") && self.role?("student")
      errors.add :roles, "a student can't be extern at the same time"
    end
    roles.each do |role|
      unless ROLES.include?(role)
        errors.add :roles, "the role #{role} was not defined"
      end
    end
  end

end

